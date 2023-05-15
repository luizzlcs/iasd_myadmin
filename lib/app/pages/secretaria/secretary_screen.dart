import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/model/activity.dart';
import 'package:iasd_myadmin/app/pages/departament/components/app_drawe_activities.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';

class SecretaryScreen extends StatefulWidget {
  const SecretaryScreen({Key? key}) : super(key: key);

  @override
  State<SecretaryScreen> createState() => _SecretaryScreenState();
}

class _SecretaryScreenState extends State<SecretaryScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Departaments? depart;
  List<Activity> listActivities = [];

  PlatformFile? file;

   @override
  void initState() {
    refresh();
    super.initState();
  }

   Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      file = result.files.first;
    });
  }

 

  void refresh() async {
    List<Activity> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('departaments')
        .doc(depart!.id)
        .collection('activity')
        .get();

    for (var doc in snapshot.docs) {
      Activity activities = Activity.fromMap(doc.data());
      temp.add(activities);
      for (var element in temp) {
        print('O QUE TEM AQUI >>> $element');
       }
    }
    setState(() {
      listActivities = temp;

      for (var element in temp) {
        print('O QUE TEM AQUI >>> $element');
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Departaments departamentOpen =
        ModalRoute.of(context)?.settings.arguments as Departaments;
    setState(() {
      depart = departamentOpen;     
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(departamentOpen.name),
      ),
      drawer: AppDrawerActivities(activities: listActivities ?? []),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              refresh();
              for (var element in listActivities) {
                print(element.name);
              }
            }, child: const Text('Buscando dados...')),
            const SizedBox(
               height: 30,
            ),
            ElevatedButton(
              onPressed: selectFile,
              child: const Text('Selecionar Arquivo'),
            ),
          ],
        ),
      ),
    );
  }
}
