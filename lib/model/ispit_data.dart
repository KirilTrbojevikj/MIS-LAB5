import 'package:flutter/foundation.dart';

class IspitData {
  final String id;
  final String predmet;
  final String? location;
  final DateTime? data;

  IspitData({
    required this.id,
    required this.predmet,
    this.location,
    this.data});
}