import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/departament/components/app_drawe_activities.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';

class DepartamentsPages extends StatefulWidget {
 
 const DepartamentsPages({Key? key}) : super(key: key);

  @override
  State<DepartamentsPages> createState() => _DepartamentsPagesState();
  }

class _DepartamentsPagesState extends State<DepartamentsPages> {

PlatformFile? file;

Future selectFile() async {
final result = await FilePicker.platform.pickFiles();
if (result == null) return;

setState(() {
  file = result.files.first;
});
}


  @override
  Widget build(BuildContext context) {
    final Departaments departamentOpen = ModalRoute.of(context)?.settings.arguments as Departaments;
    return Scaffold(
      appBar: AppBar(
        title:  Text(departamentOpen.name),
      ),
      drawer: AppDrawerActivities(activities: departamentOpen.activity ??[]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
