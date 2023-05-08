import 'dart:convert';

import 'package:flutter/material.dart';

class Activity {
  final String? id;
  final String name;
  final IconData? icon;
  final DateTime date = DateTime.now();
  final String page;

  Activity({
     this.id,
    required this.name,
    this.icon,
    required this.page,
  }
  
  );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    if(icon != null){
      result.addAll({'icon': icon!.codePoint});
    }
    result.addAll({'page': page});
  
    return result;
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      icon: map['icon'] != null ? IconData(map['icon'], fontFamily: 'MaterialIcons') : null,
      page: map['page'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) => Activity.fromMap(json.decode(source));
}
