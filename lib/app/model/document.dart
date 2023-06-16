import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/model/type_document.dart';

class Document with ChangeNotifier {
   String? id;
  final String name;
  final String description;
  final String documentUrl;
  final DateTime createAt = DateTime.now();
  final String createdBy;
  List<TypeDocument> typeDocument = [];

  Document({
    this.id,
    required this.name,
    required this.description,
    required this.documentUrl,
    required this.createdBy, 
    required this.typeDocument,
});

Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'documentUrl': documentUrl});
    result.addAll({'createdBy': createdBy});
    result.addAll({'typeDocument': typeDocument.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory Document.fromMap(Map<String, dynamic> map, {String? id}) {
    return Document(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      documentUrl: map['documentUrl'] ?? '',
      createdBy: map['createdBy'] ?? '',
      typeDocument: List<TypeDocument>.from(map['typeDocument']?.map((x) => TypeDocument.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Document.fromJson(String source) => Document.fromMap(json.decode(source));

}