import 'package:flutter/material.dart';
import 'package:mis_lab5/model/ispit_data.dart';

class Ispit extends StatelessWidget{
  static  const routeName = '/exam_detail';

  @override
  Widget build(BuildContext context) {
    final item=ModalRoute.of(context)!.settings.arguments as IspitData;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.predmet),
      ),
      body: Column(
        children: [
          Text(item.predmet),
          Text(item.data.toString()),
          Text(item.id),
        ],
      ),
    );
  }
}