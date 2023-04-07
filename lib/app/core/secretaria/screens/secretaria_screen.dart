import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/components/app_drawer.dart';

class SecretariaScreen extends StatelessWidget {
  const SecretariaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamento aqui'),
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.construction,
              size: 120,
            ),
            Text(
              'Pagina em construção',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
