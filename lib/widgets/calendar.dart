import 'package:flutter/material.dart';
import 'package:mis_lab5/model/ispit_data.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatelessWidget {

  static const routeName = '/calendar';

  @override
  Widget build(BuildContext context){
    final items = ModalRoute.of(context)
    !.settings.arguments as List<IspitData>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar"),

      ),
      body: SfCalendar(
        view: CalendarView.week,
        dataSource: MeetingDataSource(getAppointments(items)),
      ),
    );
  }

  List<Appointment> getAppointments(List<IspitData> items){
    List<Appointment> meetings = <Appointment>[];
    for (var element in items) {
      meetings.add(Appointment(
        startTime: element.data,
        endTime: element.data?.add(const Duration(hours: 2)),
        subject: element.predmet,
        color: Colors.blue,
      ));
    }
    return meetings;

  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}