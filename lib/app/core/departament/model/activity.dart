import 'package:flutter/material.dart';

class Activity {
  final String id;
  final String name;
  final IconData? icon;
  final DateTime date = DateTime.now();
  final String page;

  Activity({
    required this.id,
    required this.name,
    this.icon,
    required this.page,
  }
  
  );
}
