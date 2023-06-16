import 'dart:convert';

import 'package:flutter/material.dart';

class TypeDocument with ChangeNotifier {
  String? id;
  final String name;
  final String description;
  final DateTime createAt = DateTime.now();
  final String createdBy;

  TypeDocument({
    this.id,
    required this.name,
    required this.description, 
    required this.createdBy,
    });

    Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'createAt': createAt});
    result.addAll({'description': description});
    result.addAll({'createdBy': createdBy});
  
    return result;
  }

  factory TypeDocument.fromMap(Map<String, dynamic> map) {
    return TypeDocument(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      createdBy: map['createdBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeDocument.fromJson(String source) => TypeDocument.fromMap(json.decode(source));
}