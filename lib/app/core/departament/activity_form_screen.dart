import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';

import '../../components/icon_picker.dart';

class ActivityFormScreen extends StatefulWidget {
  const ActivityFormScreen({Key? key}) : super(key: key);

  @override
  State<ActivityFormScreen> createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen> {
  IconData? selectedIcon;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameEC = TextEditingController();
  TextEditingController descricaoEC = TextEditingController();
  TextEditingController iconeEC = TextEditingController();

  _submitForm() {
    debugPrint('Salvando dados');
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }
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
                validator: (value) {
                  final values = value ?? '';
                  if (values.trim().isEmpty) {
                    return 'É necessário informar o nome da atividade';
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
                    labelText: 'Page',
                    hintText: 'Descrição da atividade',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  final values = value ?? '';
                  if (values.trim().isEmpty) {
                    return 'É necessário fazer uma descrição para a atividade.';
                  }
                  return null;
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
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  final IconData? result = await showIconPicker(
                      context: context, defalutIcon: selectedIcon);
                  setState(() {
                    selectedIcon = result;
                  });
                },
                child: const Text('Selected Icon'),
              ),
              const Padding(padding: EdgeInsets.all(5)),
              selectedIcon != null ? Icon(selectedIcon, color: Colors.deepOrange) : const Text('Selecione um ícone'),
              const Padding(padding: EdgeInsets.all(5)),

              ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
                onPressed: () {
                  Activity newActivity = Activity(
                    id: Random().nextDouble().toString(),
                    name: nameEC.text,
                    page: descricaoEC.text,
                  );

                  Navigator.pop(context, newActivity);
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
