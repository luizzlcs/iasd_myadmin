import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/model/activity.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';

class DepartamentsController with ChangeNotifier {

  List<Departaments> _departament = [];

  List<Departaments> get departament => [..._departament];

  void getDepartments() {
    FirebaseFirestore.instance
        .collection('departments')
        .get()
        .then((querySnapshot) {
      for (var document in querySnapshot.docs) {
        Departaments department = Departaments(
          id: document.id,
          name: document.data()['name'],
          description: document.data()['description'],
          imageUrl: document.data()['imageUrl'],
        );
        _departament.add(department);
      }
      notifyListeners();
    });
  }


  void addActivity(Activity activities, int index) {
    notifyListeners();
  }

  void removActivity(
      {required int departamentIndex, required int activityIdex}) {
    notifyListeners();
  }

  void addDepartaments(Departaments departament) {
    _departament.add(departament);
    notifyListeners();
  }

  void updateDepartaments(Departaments departament) {
    int index = _departament.indexWhere((d) => d.id == departament.id);

    if (index >= 0) {
      _departament[index] = departament;
      notifyListeners();
    }
  }
}
