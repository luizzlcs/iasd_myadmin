import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/core/departament/creat_departaments.dart';
import 'package:provider/provider.dart';

import 'list_activity_screen.dart';

class ListDepartamentScreen extends StatefulWidget {
  const ListDepartamentScreen({Key? key}) : super(key: key);

  @override
  State<ListDepartamentScreen> createState() => _ListDepartamentScreenState();
}

class _ListDepartamentScreenState extends State<ListDepartamentScreen> {
  
  
 
  /* List<Departaments> listDepartaments = [
    Departaments(
      id: '11',
      name: 'Desbravadores',
      description: 'Para Crianças',
      imageUrl: 'null',
      activity: [],
    ),
    Departaments(
      id: '12',
      name: 'Jovens',
      description: 'Acima de 18 anos',
      imageUrl: 'null',
      activity: [],
    ),
    Departaments(
      id: '13',
      name: 'Aventureiros',
      description: '6 a 9 anos',
      imageUrl: 'null',
      activity: [],
    ),
  ]; */

  @override
  Widget build(BuildContext context) {
    final listDepartaments = Provider.of<DepartamentsController>(context, listen: true).departament;

   
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Departamentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: listDepartaments.length,
          itemBuilder: (context, index) {
            return Card(
              color: const Color.fromARGB(255, 130, 131, 134),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple ,
                  backgroundImage: NetworkImage(listDepartaments[index].imageUrl),
                  child: Text(listDepartaments[index].name.substring(0,3)),
                ),
                title: Text(listDepartaments[index].name),
                subtitle: Text(listDepartaments[index].description),
                
                hoverColor: Colors.deepOrange,
                onTap: () {
                  debugPrint(' Indice Departamento ${listDepartaments[index].name.toString()} $index');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ListActivityScreen(departaments: listDepartaments[index], index: index),
                      
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatDepartaments()),
          ).then((newDepartaments) {
            if (newDepartaments != null) {
              setState(() {
                listDepartaments.add(newDepartaments);
                
              });
            }
          });
        },
      ),
    );
  }
}
