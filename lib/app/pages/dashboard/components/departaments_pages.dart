import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/departament/components/app_drawe_activities.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../model/activity.dart';

class DepartamentsPages extends StatefulWidget {
  const DepartamentsPages({Key? key}) : super(key: key);

  @override
  State<DepartamentsPages> createState() => _DepartamentsPagesState();
}

class _DepartamentsPagesState extends State<DepartamentsPages> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController nameEC = TextEditingController();
  TextEditingController descricaoEC = TextEditingController();
  TextEditingController imageEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode descricaoFocus = FocusNode();
  FocusNode nameFocus = FocusNode();
  FocusNode imageFocus = FocusNode();
  FocusNode textButtonSaveFocus = FocusNode();

  final items = ['Atas', 'Atos', 'Notas', 'Declarações'];
  var selectedValue = 'Atas';

  bool isLoading = false;
  bool isProgressBar = false;
  int _progress = 0;

  List disposable = [];

  File? file;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      file = File(result.files.single.path as String);
    });
    _processFile();
  }

  @override
  void dispose() {
    for (var disposables in disposable) {
      disposables.dispose();
    }
    super.dispose();
  }

  void _processFile() {
    const duration = Duration(milliseconds: 5);
    const step = 1;
    int totalSteps = (100 / step).ceil();

    int currentStep = 0;
    Timer.periodic(duration, (timer) {
      currentStep++;

      if (currentStep <= totalSteps) {
        setState(() {
          _progress = currentStep * step;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Departaments departamentOpen =
        ModalRoute.of(context)?.settings.arguments as Departaments;
    return Scaffold(
      appBar: AppBar(
        title: Text(departamentOpen.name),
      ),
      drawer: AppDrawerActivities(activities: departamentOpen.activity),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameEC,
                      autofocus: true,
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: 'Nome',
                        hintText: 'Nome do departamento',
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(descricaoFocus),
                      validator: (value) {
                        final values = value ?? '';
                        if (values.trim().isEmpty) {
                          return 'É necessário informar o nome do departamento';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descricaoEC,
                      decoration: const InputDecoration(
                          isDense: true,
                          labelText: 'Decrição',
                          hintText: 'Descrição do departamento',
                          border: OutlineInputBorder()),
                      textInputAction: TextInputAction.next,
                      focusNode: descricaoFocus,
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(imageFocus),
                      validator: (value) {
                        final values = value ?? '';
                        if (values.trim().isEmpty) {
                          return 'É necessário fazer uma descrição para o departamento';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Categoria'),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: const Text('Selecione uma categoria'),
                                  isExpanded: false,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValue = value as String;
                                    });
                                  },
                                  items: items.map((valeuKey) {
                                    return DropdownMenuItem<String>(
                                      value: valeuKey,
                                      child: Text(valeuKey),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            FloatingActionButton.small(
                              onPressed:() {},
                              child: const Icon(Icons.add),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                      onPressed: selectFile,
                      icon: const Icon(Icons.file_upload_outlined),
                      label: const Text('Selecionar Arquivo'),
                    ),
                    if (file != null)
                      if (_progress < 100)
                        LinearPercentIndicator(
                          center: Text('$_progress %'),
                          barRadius: const Radius.circular(70.0),
                          animation: true,
                          animationDuration: 1950,
                          lineHeight: 40,
                          percent: 1,
                          progressColor: Colors.deepPurple,
                          backgroundColor: Colors.deepPurple.shade200,
                        ),
                    const SizedBox(
                      height: 10,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return _progress < 100
                            ? const CircularProgressIndicator()
                            : ElevatedButton.icon(
                                focusNode: textButtonSaveFocus,
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(300, 50)),
                                onPressed: () async {
                                  final isValid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (isValid) {
                                    final name = nameEC.text;
                                    final descricao = descricaoEC.text;
                                    final image = imageEC.text;

                                    // Se o formulário for válido HABILITA o CircularProgressIndicator
                                    setState(
                                      () {
                                        if (isValid) {
                                          isLoading = true;
                                          //refresh();
                                        }
                                      },
                                    );

                                    Departaments newDepartaments = Departaments(
                                      name: name,
                                      description: descricao,
                                      imageUrl: image,
                                      activity: [
                                        Activity(
                                          name: 'Home',
                                          page: '/dashBoard',
                                          icon: Icons.home,
                                        ),
                                      ],
                                    );

                                    final firestore =
                                        FirebaseFirestore.instance;

                                    var query = await firestore
                                        .collection('departaments')
                                        .add(
                                          newDepartaments.toMap(),
                                        );
                                    newDepartaments.id = query.id;
                                    debugPrint(
                                        'COLLECTION: ${query.parent.path} ID: ${query.id}');

                                    // Se o formulário for válido DESABILITA o CircularProgressIndicator
                                    setState(
                                      () {
                                        if (isValid) {
                                          isLoading = false;
                                        }
                                      },
                                    );
                                    Navigator.of(context).pop();
                                    return;
                                  }
                                },
                                icon: const Icon(Icons.save),
                                label: const Text('Salvar'),
                              );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
