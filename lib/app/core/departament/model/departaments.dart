import 'package:flutter/material.dart';

class Departaments with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  Departaments({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}
