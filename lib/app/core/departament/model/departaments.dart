import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';

class Departaments with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  List<Activity> activity;


  Departaments({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.activity,
  });

// Activity(id: '1', name: 'Luiz', icon: Icons.card_membership, date: DateTime.now(), page: '/teste')
  List<Activity> listActivity = [];

  saveActivities(Map<String, dynamic> data) {
    bool hasId = data['id'] != null;
    final activities = Activity(
      id: hasId ? data['id'] : Random().nextDouble().toString(),
      name: data['name'],
      page: data['page'],
    );
    if (hasId) {
      updateActivity(activities);
    } else {
      addActivity(activities);
    }
  }

  void addActivity(Activity activities){
    listActivity.add(activities);
    notifyListeners();
  }

  void updateActivity(Activity activities){
    int index = listActivity.indexWhere((d) => d.id == activities);
    if(index >= 0){
      listActivity[index] = activities;
      notifyListeners();
    } 

  }
}
