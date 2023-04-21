import 'package:flutter/material.dart';

class Activity {
  String id;
  String name;
  IconData icon;
  DateTime date;
  String page;

  Activity({
    required this.id,
    required this.name,
    required this.icon,
    required this.date,
    required this.page,
  });
}
