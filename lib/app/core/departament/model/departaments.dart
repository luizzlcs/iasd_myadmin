import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';

class Departaments with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  List<Activity> activity = [];


  Departaments({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.activity,
  });


  void addActivity(Activity activities){
    activity.add(activities);
    notifyListeners();
  }

   void removActivity(int index){
    activity.removeAt(index);
  }

  void updateActivity(Activity activities){
    int index = activity.indexWhere((d) => d.id == activities);
    if(index >= 0){
      activity[index] = activities;
      notifyListeners();
    } 

  }

 
}
