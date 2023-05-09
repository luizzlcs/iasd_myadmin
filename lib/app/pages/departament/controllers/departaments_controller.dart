import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/model/activity.dart';
import 'package:iasd_myadmin/app/data/dummy_data.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';

class DepartamentsController with ChangeNotifier {
  final List<Departaments> _departament = [...dummyData];

  List<Departaments> get departament => [..._departament];


void addActivity(Activity activities, int index){
    _departament[index].activity.add(activities);
    notifyListeners();
  }

   void removActivity({ required int departamentIndex, required int activityIdex}){
    _departament[departamentIndex].activity.removeAt(activityIdex);
    notifyListeners();
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
