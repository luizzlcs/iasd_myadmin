import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/model/activity.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';
import 'package:provider/provider.dart';

import '../../components/icon_picker.dart';
import '../../themes/app_theme.dart';
import 'controllers/departaments_controller.dart';

class ListActivityScreen extends StatefulWidget {
  final Departaments departaments;
  final int index;

  const ListActivityScreen(
      {required this.departaments, required this.index, super.key});

  @override
  _ListActivityScreenState createState() => _ListActivityScreenState();
}

class _ListActivityScreenState extends State<ListActivityScreen> {
  void createType(context) {
    final isDark = Provider.of<AppTheme>(context, listen: false).isDark();
    TextEditingController nameActivityEC = TextEditingController();
    TextEditingController nameRouteEC = TextEditingController();
    IconData? selectedIcon;
    FocusNode nameRoute = FocusNode();
    FocusNode selectIcon = FocusNode();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Cadastra nova página de atividade'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      autofocus: true,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(nameRoute);
                      },
                      controller: nameActivityEC,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Nome da atividade',
                        icon: Icon(Icons.data_exploration),
                      ),
                    ),
                    TextFormField(
                      focusNode: nameRoute,
                      controller: nameRouteEC,
                      decoration: const InputDecoration(
                        labelText: 'Rota da pagina',
                        icon: Icon(Icons.apps_outage),
                      ),
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(selectIcon),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Column(children: [
                        const Padding(padding: EdgeInsets.all(5)),
                        selectedIcon != null
                            ? Icon(selectedIcon, color: Colors.deepOrange)
                            : const Text('Selecione um ícone'),
                        const Padding(padding: EdgeInsets.all(5)),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              focusNode: selectIcon,
                              onPressed: () async {
                                final IconData? result = await showIconPicker(
                                    isDark: isDark,
                                    context: context,
                                    defalutIcon: selectedIcon);
                                setState(() {
                                  selectedIcon = result;
                                });
                              },
                              child: const Text('Selecionar icone')),
                        ),
                      ]);
                    }),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  child: const Text("Salvar"),
                  onPressed: () {
                    selectedIcon ??= Icons.credit_score;
                    final newActivities = Activity(
                      id: Random().nextDouble().toString(),
                      name: nameActivityEC.text,
                      page: nameRouteEC.text,
                      icon: selectedIcon,
                    );

                    Provider.of<DepartamentsController>(context, listen: false)
                        .addActivity(newActivities, widget.index);
                    selectedIcon = null;
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text("Calcelar"),
                  onPressed: () async {
                    selectedIcon = null;
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final listActivities =
        Provider.of<DepartamentsController>(context).departament;
    final isDark = Provider.of<AppTheme>(
      context,
    ).isDark();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu de atividades '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.99,
              child: Card(
                shadowColor: Colors.black54,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.departaments.name.toUpperCase(),
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.departaments.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.99,
                        child: Card(
                            color: isDark
                                ? const Color.fromARGB(255, 87, 85, 85)
                                : Colors.white,
                            shadowColor: Colors.black,
                            elevation: 3,
                            child: const Padding(
                              padding: EdgeInsets.all(16),
                              child: Text("Lista de munus das atividades"),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                shadowColor: Colors.black,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: widget.departaments.activity.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shadowColor: Colors.black,
                        elevation: 9,
                        color: const Color.fromARGB(255, 130, 131, 134),
                        surfaceTintColor: Colors.amber[200],
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(listActivities[widget.index]
                                .activity[index]
                                .icon),
                          ),
                          title: Text(listActivities[widget.index]
                              .activity[index]
                              .name),
                          subtitle: Text(listActivities[widget.index]
                              .activity[index]
                              .page),
                          hoverColor: Colors.deepOrange,
                          onTap: () {
                            Provider.of<DepartamentsController>(context,
                                    listen: false)
                                .removActivity(
                                    departamentIndex: widget.index,
                                    activityIdex: index);
                            debugPrint('Index Departamento: ${widget.index}');
                            debugPrint('Index atividade: $index');
                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          createType(context);
        },
      ),
    );
  }
}
