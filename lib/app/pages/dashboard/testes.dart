import 'package:flutter/material.dart';

class Testes extends StatelessWidget {
  const Testes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Row e Column'),
      ),
      body: Container(
        color: Colors.pink.withOpacity(0.3),
        height: 600,
        child: Row(        
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.blue,
            ),
            const SizedBox(width: 5),
            Container(
              width: 100,
              height: 100,
              color: Colors.deepPurple,
            ),
             const SizedBox(width: 5),
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
