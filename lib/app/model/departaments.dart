import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:iasd_myadmin/app/model/activity.dart';

class Departaments with ChangeNotifier {
  String? id;
  final String name;
  final String description;
  final String imageUrl;

  Departaments({
     this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });



  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'imageUrl': imageUrl});
  
    return result;
  }

  factory Departaments.fromMap(Map<String, dynamic> map, {String? id}) {
    return Departaments(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Departaments.fromJson(String source) => Departaments.fromMap(json.decode(source));
}
