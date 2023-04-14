import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/components/app_drawer.dart';
import 'package:iasd_myadmin/app/core/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';

class SecretariaScreen extends StatefulWidget {
 
 const SecretariaScreen({Key? key}) : super(key: key);

  @override
  State<SecretariaScreen> createState() => _SecretariaScreenState();
  }

class _SecretariaScreenState extends State<SecretariaScreen> {

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
    final DepartamentsController departamentOpen = ModalRoute.of(context)!.settings.arguments as DepartamentsController;
    return Scaffold(
      appBar: AppBar(
        title:  Text(departamentOpen.departament[17].name),
      ),
      drawer: const AppDrawer(),
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
