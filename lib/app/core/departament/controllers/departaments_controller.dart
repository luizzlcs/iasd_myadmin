import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/data/dummy_data.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';

class DepartamentsController with ChangeNotifier {
  final List<Departaments> _departament = [...dummyData];

  List<Departaments> get departament => [..._departament];

  saveDepartaments(Map<String, dynamic> data) {
    bool hasId = data['id'] != null;
    final departament = Departaments(
      id: hasId ? data['id'] : Random().nextDouble().toString(),
      name: data['name'],
      description: data['description'],
      imageUrl: data['image'],
    );
    if (hasId) {
      updateDepartaments(departament);
    } else {
      addDepartaments(departament);
    }
  }

  void addDepartaments(Departaments departament) {
    _departament.add(departament);
    notifyListeners();
  }

  void updateDepartaments(Departaments departament){
    int index = _departament.indexWhere((d) => d.id == departament.id);

    if(index >= 0){
      _departament[index] = departament;
      notifyListeners();
    } 

  }
}
