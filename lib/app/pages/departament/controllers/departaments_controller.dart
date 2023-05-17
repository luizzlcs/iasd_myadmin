
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/model/activity.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';

class DepartamentsController with ChangeNotifier {
  /*  final List<Departaments> _departament = [...dummyData];

  List<Departaments> get departament => [..._departament]; */
  List<Departaments> _departament = [];

  List<Departaments> get departament => [..._departament];
// -----------

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
            activity: document.data()[Activity(
              name: document.data()['name'],
              page: document.data()['page'],
              icon: document.data()['icon'],
            )]);
        _departament.add(department);
      }
      notifyListeners();
    });
  }

// ----------

  // final List<Departaments> _departament = [];

  /* FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> loadDepartaments() async {
    List<Departaments> departaments = await getAllDepartaments();
    _departament = departaments;
    notifyListeners();
  }
  

  Future<List<Departaments>> getAllDepartaments() async {
    List<Departaments> departaments = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('departaments').get();

    for (var doc in querySnapshot.docs) {
      Departaments departament = Departaments.fromMap(doc.data());
      departaments.add(departament);
    }

    return departaments;
  } */

  void addActivity(Activity activities, int index) {
    _departament[index].activity.add(activities);
    notifyListeners();
  }

  void removActivity(
      {required int departamentIndex, required int activityIdex}) {
    _departament[departamentIndex].activity.removeAt(activityIdex);
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
