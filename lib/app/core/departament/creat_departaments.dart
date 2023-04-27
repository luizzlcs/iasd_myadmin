import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';
import 'package:provider/provider.dart';

class CreatDepartaments extends StatefulWidget {
  const CreatDepartaments({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatDepartaments> createState() => _CreatDepartamentsState();
}

class _CreatDepartamentsState extends State<CreatDepartaments> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de departamentos'),
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
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
                onPressed: () {
                  final name = nameEC.text;
                  final descricao = descricaoEC.text;
                  final image = imageEC.text;

                  Departaments newDepartaments = Departaments(
                    id: Random().nextDouble().toString(),
                    name: name,
                    description: descricao,
                    imageUrl: image,
                    activity: [
                      Activity(
                        id: Random().nextDouble().toString(),
                        name: 'Painel',
                        page: '/dashBoard',
                        icon: Icons.arrow_circle_left_outlined,
                      ),
                    ],
                  );
                  debugPrint(newDepartaments.id);
                  debugPrint(newDepartaments.name);
                  debugPrint(newDepartaments.imageUrl);
                  Provider.of<DepartamentsController>(context, listen: false)
                      .addDepartaments(newDepartaments);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(AppRoutes.activityScreen),
                child: const Text('Criar atividades'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
