import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScrenUserData extends StatelessWidget {
  
  const ScrenUserData({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    var name = user?.displayName;
    var email = user?.email;
    debugPrint('Imprimindo email: ${name ?? ''}');
    debugPrint('Imprimindo nome: ${email ?? ''}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do Usuário'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Datos qui:'),
            Text(name ?? ''),
            Text(email ?? ''),
          ],
        ),
      ),
    );
  }
}
