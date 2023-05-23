import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> showCustomDialog(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;
  
    var name = user?.displayName;
    var email = user?.email;
    debugPrint(email);
    debugPrint(user?.uid);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Card(
          child: AlertDialog(
            title: const Text('Título do diálogo'),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Nome: $name'),
                const SizedBox(
                  height: 15,
                ),
                Text('E-mail: $email'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fechar o diálogo
                },
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }

