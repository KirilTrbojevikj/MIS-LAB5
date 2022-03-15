import 'package:flutter/material.dart';
import 'package:mis_lab5/model/ispit_data.dart';
import 'package:mis_lab5/widgets/map_widget.dart';
import 'package:nanoid/nanoid.dart';
import 'package:mis_lab5/widgets/ispit.dart';
import 'package:mis_lab5/widgets/calendar.dart';

class MainWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MainWidgetState();
  }
}

class _MainWidgetState extends State<MainWidget> {
  final String title = "Student Organizer";

  List<IspitData> _ispitItem = [
    IspitData(id: nanoid(5),
        predmet: "Verojatnost i Statistika",
        data: DateTime.parse('2022-03-13 10:00'),
        location: "Ruger Boshkovikj 16, Skopje 1000"),
    IspitData(id: nanoid(5),
        predmet: "Operativni Sistemi",
        data: DateTime.parse('2022-03-13 14:00'),
        location: "Ruger Boshkovikj 16, Skopje 1000"),
    IspitData(id: nanoid(5),
        predmet: "Infomaciska Bezbednost",
        data: DateTime.parse('2022-03-15 08:00'),
        location: "Ruger Boshkovikj 16, Skopje 1000",),
    IspitData(id: nanoid(5),
        predmet: "Procesiranje na signali",
        data: DateTime.parse('2022-03-19 18:00'),
        location: "Ruger Boshkovikj 16, Skopje 1000")
  ];

  final predmetController = TextEditingController();
  final dataController = TextEditingController();
  final locationController = TextEditingController();

  void addItem(){
    if (predmetController.text.isEmpty)
    {
      return;
    }
    setState(() {
      IspitData newItem = IspitData(
        id: nanoid(5),
        predmet: predmetController.text,
        data: DateTime.parse(dataController.text),
      );
      predmetController.text = "";
      dataController.text = "";
      locationController.text = "";
      _ispitItem.add(newItem);
      Navigator.pop(context);
    });
  }

  void deleteItem(String id) {
    setState(() {
      _ispitItem.removeWhere((element) => element.id == id);
    });
  }

  void showDetails(BuildContext context, IspitData item) {
    Navigator.of(context).pushNamed(
        Ispit.routeName,
        arguments: item
    );
  }

  void ShowCalendar(BuildContext context, List<IspitData> items) {
    Navigator.of(context).pushNamed(
        CalendarWidget.routeName,
        arguments: items
    );
  }

  void ShowMap(BuildContext context, List<IspitData> items){
    Navigator.of(context).pushNamed(
      Map.routeName,
      arguments: items
    );
  }

  Widget createBody() {
    return Column(
      children: [
        Expanded(
            child: _ispitItem.isEmpty ?
            Center(child: Text(
                "No exams",
                style: const TextStyle(fontWeight: FontWeight.bold)
            )
              ,) :
            ListView.builder(
              itemCount: _ispitItem.length,
              itemBuilder: (context, index) {
                print(_ispitItem[index]);
                return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text(_ispitItem[index].predmet),
                          subtitle: Text(_ispitItem[index].data.toString()),
                          onTap: () => showDetails(context, _ispitItem[index]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.where_to_vote),
                              onPressed: () => ShowMap(context, _ispitItem),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => deleteItem(_ispitItem[index].id),
                            ),
                            const SizedBox(width: 8),
                          ],
                        )
                      ],
                    ),
                );
              },
            )
        ),
      ],
    );
  }

  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(onPressed: () {
          showDialog(context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 20
                  ),
                  title: Row(
                    children: [
                      Text("Add exam"),
                      Spacer(),
                      IconButton(onPressed: () {
                        Navigator.pop(context);
                      },
                          icon: Icon(Icons.cancel))
                    ],
                  ),
                  children: [
                    Divider(height: 5, indent: 5),
                    TextFormField(
                      controller: predmetController,
                      decoration: InputDecoration(
                        hintText: "Name of subject",
                      ),
                    ),
                    TextFormField(
                      controller: dataController,
                      decoration: InputDecoration(
                        hintText: "Date & Time",
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    Divider(height: 5, indent: 5),
                    TextFormField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: "Location of event",
                      ),
                    ),
                    Divider(height: 5, indent: 5),
                    Spacer(),
                    SizedBox(
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: FlatButton(
                        child: Text("Add"),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          addItem();
                        },
                      ),
                    )
                  ],
                );
              });
        },
          icon: Icon(Icons.add, size: 35),
          padding: EdgeInsets.only(right: 40),
        ),
        IconButton(onPressed: () => ShowCalendar(context, _ispitItem), icon: Icon(Icons.calendar_today))
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: createBody(),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () => ShowMap(context, _ispitItem),
        tooltip: 'Map',
        child: const Icon(Icons.where_to_vote),
      ),*/
    );
  }
}