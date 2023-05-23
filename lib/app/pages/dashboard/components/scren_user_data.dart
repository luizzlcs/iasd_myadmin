import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';

class ScrenUserData extends StatelessWidget {
  const ScrenUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    final user = FirebaseAuth.instance.currentUser;

    var name = user?.displayName;
    var email = user?.email;
    var photoURL = user?.photoURL;
    debugPrint('Imprimindo email: ${name ?? ''}');
    debugPrint('Imprimindo nome: ${email ?? ''}');

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.dashBoard, (route) => false);
              },
              icon: const Icon(Icons.exit_to_app_outlined))
        ],
        title: Center(child: const Text('Pefil do usuário')),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircleAvatar(
                maxRadius: 80,
                backgroundImage: ResizeImage(
                  NetworkImage(
                    photoURL ??
                        'https://cdn.pixabay.com/photo/2021/06/07/13/46/user-6318008_960_720.png',
                  ),
                  width: 160,
                  height: 160,
                ),
              ),
            ),
            Container(
              width: sizeWidth * 40,
              height: sizeHeight * 50,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nome: ${name ?? ''}'),
                      Text('E-mail: ${email ?? ''}'),
                    ],  
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
