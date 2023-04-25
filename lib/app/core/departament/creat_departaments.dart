
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';
import 'package:provider/provider.dart';

class CreatDepartaments extends StatefulWidget {
  const CreatDepartaments({Key? key}) : super(key: key);

  @override
  State<CreatDepartaments> createState() => _CreatDepartamentsState();
}

class _CreatDepartamentsState extends State<CreatDepartaments> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  final List<Activity> _formActivity = [];
  _submitForm() {
    debugPrint('Salvando dados');
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<DepartamentsController>(context, listen: false)
        .saveDepartaments(_formData, _formActivity );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de departamento'),
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
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Nome',
                    hintText: 'Nome do departamento',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_value) {
                  final value = _value ?? '';
                  if (value.trim().isEmpty) {
                    return 'É necessário informar o nome do departamento';
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    isDense: true,
                    labelText: 'Decrição',
                    hintText: 'Descrição do departamento',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                onSaved: (descricao) =>
                    _formData['description'] = descricao ?? '',
                validator: (_value) {
                  final value = _value ?? '';
                  if (value.trim().isEmpty) {
                    return 'É necessário fazer uma descrição para o departamento';
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                  decoration: const InputDecoration(
                      isDense: true,
                      labelText: 'Imgaem',
                      hintText: 'Imagem do departamento',
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
                onPressed: () => _submitForm(),
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
              ),
              const SizedBox(
                 height: 15,
              ),
              TextButton(onPressed: ()=> Navigator.of(context).pushNamed(AppRoutes.activityScreen)
              , child: const Text('Criar atividades'),)
            ],
          ),
        ),
      ),
    );
  }
}
