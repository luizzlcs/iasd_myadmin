import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';

class Departaments with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  List<Activity>? activity;


  Departaments({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.activity,
  });
}
