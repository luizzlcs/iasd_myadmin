import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/components/app_drawer.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secretaria'),
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
