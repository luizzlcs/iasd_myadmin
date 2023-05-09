import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:iasd_myadmin/app/model/activity.dart';

class Departaments with ChangeNotifier {
  String? id;
  final String name;
  final String description;
  final String imageUrl;
  List<Activity> activity = [];

  Departaments({
     this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.activity,
  });

  void updateActivity(Activity activities) {
    int index = activity.indexWhere((d) => d.id == activities);
    if (index >= 0) {
      activity[index] = activities;
      notifyListeners();
    }
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'activity': activity.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory Departaments.fromMap(Map<String, dynamic> map) {
    return Departaments(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      activity: List<Activity>.from(map['activity']?.map((x) => Activity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Departaments.fromJson(String source) => Departaments.fromMap(json.decode(source));
}
