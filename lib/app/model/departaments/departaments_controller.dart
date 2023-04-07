import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/data/dummy_data.dart';
import 'package:iasd_myadmin/app/model/departaments/departaments.dart';

class DepartamentsController with ChangeNotifier {
  final List<Departaments> _departament = [...dummyData];

  List<Departaments> get departament => [..._departament];
}
