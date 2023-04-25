import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';
import 'package:provider/provider.dart';

class ActivityFormScreen extends StatefulWidget {
  const ActivityFormScreen({Key? key}) : super(key: key);

  @override
  State<ActivityFormScreen> createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};

  TextEditingController nameEC = TextEditingController();
  TextEditingController descricaoEC = TextEditingController();
  TextEditingController iconeEC = TextEditingController();

  _submitForm() {
    debugPrint('Salvando dados');
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<Departaments>(context, listen: false).saveActivities(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Atividades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
                    hintText: 'Nome da atividade',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_value) {
                  final value = _value ?? '';
                  if (value.trim().isEmpty) {
                    return 'É necessário informar o nome da atividade';
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: descricaoEC,
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Page',
                    hintText: 'Descrição da atividade',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                onSaved: (descricao) =>
                    _formData['description'] = descricao ?? '',
                validator: (_value) {
                  final value = _value ?? '';
                  if (value.trim().isEmpty) {
                    return 'É necessário fazer uma descrição para a atividade.';
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                  controller: iconeEC,
                  decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Icone',
                      hintText: 'icone da atividade',
                      border: OutlineInputBorder()),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submitForm(),
                  onSaved: (image) => _formData['image'] = image ?? ''),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
                onPressed: () {
                  
                  Activity activity = Activity(
                    id: Random().nextDouble().toString(),
                    name: nameEC.text,
                    page: descricaoEC.text,
                  );
                  print('ATIVIDADE: ${activity.name}');
                  Navigator.pop(context, activity);
                },
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
