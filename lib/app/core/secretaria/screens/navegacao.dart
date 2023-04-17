import 'package:flutter/material.dart';

class Navegacao extends StatelessWidget {

  const Navegacao({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Pagina chamada pelos menus'),),
           body: const Center(child:  Text('Página de teste')),
       );
  }
}