import 'package:flutter/material.dart';

class Testes extends StatelessWidget {

  const Testes({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text(''),),
           body: Center(
             child: Container(
              width: 300,
              height: 300,
              color: Colors.blue,
             ),
           ),
       );
  }
}