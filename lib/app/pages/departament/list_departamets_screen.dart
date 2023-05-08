import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/services/firestore_service.dart';
import 'package:provider/provider.dart';
import '../../model/activity.dart';
import '../../model/departaments.dart';
import 'list_activity_screen.dart';
import 'package:uuid/uuid.dart';

class ListDepartamentScreen extends StatefulWidget {
  const ListDepartamentScreen({Key? key}) : super(key: key);

  @override
  State<ListDepartamentScreen> createState() => _ListDepartamentScreenState();
}

class _ListDepartamentScreenState extends State<ListDepartamentScreen> {
  var uuid = Uuid();
  TextEditingController nameEC = TextEditingController();
  TextEditingController descricaoEC = TextEditingController();
  TextEditingController imageEC = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _submitForm() {
    debugPrint('Salvando dados');
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
  }

  Widget _buildModal() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Color.fromARGB(255, 97, 96, 96),
      ),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 92, 3, 92),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Cadastrar departamentos",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: formsDepartaments(),
          ),
        ],
      ),
    );
  }

  Widget formsDepartaments() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: nameEC,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'Nome',
                hintText: 'Nome do departamento',
                border: OutlineInputBorder()),
            textInputAction: TextInputAction.next,
            validator: (value) {
              final values = value ?? '';
              if (values.trim().isEmpty) {
                return 'É necessário informar o nome do departamento';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: descricaoEC,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'Decrição',
                hintText: 'Descrição do departamento',
                border: OutlineInputBorder()),
            textInputAction: TextInputAction.next,
            validator: (value) {
              final values = value ?? '';
              if (values.trim().isEmpty) {
                return 'É necessário fazer uma descrição para o departamento';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFormField(
            controller: imageEC,
            decoration: const InputDecoration(
                isDense: true,
                labelText: 'Imgem',
                hintText: 'Imagem do departamento',
                border: OutlineInputBorder()),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submitForm(),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
            onPressed: () {
              // if(_submitForm())
              final isValid = _formKey.currentState?.validate() ?? false;
              if (isValid) {
                final name = nameEC.text;
                final descricao = descricaoEC.text;
                final image = imageEC.text;

                Departaments newDepartaments = Departaments(
                  id: uuid.v1(),
                  name: name,
                  description: descricao,
                  imageUrl: image,
                  activity: [
                    Activity(
                      id: Random().nextDouble().toString(),
                      name: 'Home',
                      page: '/dashBoard',
                      icon: Icons.home,
                    ),
                  ],
                );

                final firestore = FirestoreService();

                firestore.insert(
                  collectionName: 'departaments',
                  documentName: newDepartaments.id,
                  data: newDepartaments.toMap(),
                );

                Provider.of<DepartamentsController>(context, listen: false)
                    .addDepartaments(newDepartaments);
                Navigator.of(context).pop();

                return;
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Salvar'),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listDepartaments =
        Provider.of<DepartamentsController>(context, listen: true).departament;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Departamentos'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(minWidth: 900, maxWidth: 950),
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 138, 137, 138),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: ListView.builder(
                itemCount: listDepartaments.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 55, 55, 56),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        backgroundImage:
                            NetworkImage(listDepartaments[index].imageUrl),
                        child:
                            Text(listDepartaments[index].name.substring(0, 3)),
                      ),
                      title: Text(listDepartaments[index].name),
                      subtitle: Text(listDepartaments[index].description),
                      hoverColor: Colors.deepOrange,
                      onTap: () {
                        debugPrint(
                            ' Indice Departamento ${listDepartaments[index].name.toString()} $index');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListActivityScreen(
                                departaments: listDepartaments[index],
                                index: index),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                constraints: const BoxConstraints(
                  minWidth: 900,
                  maxWidth: 950,
                  minHeight: 200,
                  maxHeight: 400,
                ),
                context: context,
                builder: (context) {
                  return _buildModal();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
