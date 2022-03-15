import 'package:flutter/material.dart';
import 'package:mis_lab5/widgets/calendar.dart';
import 'package:mis_lab5/widgets/ispit.dart';
import 'package:mis_lab5/widgets/main_widget.dart';
import 'package:mis_lab5/widgets/map_widget.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(ctx) => MainWidget(),
      Ispit.routeName: (ctx) => Ispit(),
      CalendarWidget.routeName: (ctx) => CalendarWidget(),
      Map.routeName: (ctx) => Map(),

    },
    theme: ThemeData( primarySwatch: Colors.deepOrange),
  )
  );
}
