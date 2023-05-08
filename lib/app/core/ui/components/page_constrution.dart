import 'package:flutter/material.dart';

class PageConstrution extends StatelessWidget {

  const PageConstrution({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Página em construção'),),
           body: Center(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,             
               children:  [
                 const Icon(Icons.settings_applications_sharp, size: 200,),
                 TextButton(onPressed: (){
                  Navigator.pop(context);
                 }, child: const Text('Voltar')),
               ],
             ),
           ),
       );
  }
}