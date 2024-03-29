import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/model/activity.dart';
import 'package:iasd_myadmin/app/model/departaments.dart';
import 'package:provider/provider.dart';
import '../../core/ui/components/icon_picker.dart';
import '../../core/ui/themes/app_theme.dart';
import '../../core/util/responsive.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListActivityScreen extends StatefulWidget {
  Departaments departaments;
  final int index;

  ListActivityScreen(
      {required this.departaments, required this.index, super.key});

  @override
  _ListActivityScreenState createState() => _ListActivityScreenState();
}

class _ListActivityScreenState extends State<ListActivityScreen> {
  GlobalKey<State> globalKey = GlobalKey<State>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Activity> listActivities = [];

  List disposable = [];
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    for (var disposables in disposable) {
      disposables.dispose();
    }
  }

  void getData() async {
    List<Activity> matrizData = [];

    DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection('departaments')
        .doc(widget.departaments.id)
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()!;
      if (data.containsKey('activity')) {
        matrizData = List<Activity>.from(
          data['activity'].map(
            (item) => Activity.fromMap(item),
          ),
        );
      }
    }

    setState(() {
      listActivities = matrizData;
    });
  }

  void createType(context) {
    final isDark = Provider.of<AppTheme>(context, listen: false).isDark();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController nameActivityEC = TextEditingController();
    TextEditingController nameRouteEC = TextEditingController();
    IconData? selectedIcon;
    FocusNode nameRoute = FocusNode();
    FocusNode selectIcon = FocusNode();

    disposable.add(nameActivityEC);
    disposable.add(nameRouteEC);
    disposable.add(nameRoute);
    disposable.add(selectIcon);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Cadastra nova página de atividade'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
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
                    validator: (values) {
                      final String value = values ?? '';
                      if (value.trim().isEmpty) {
                        return 'O campo deve ser prenchido.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    focusNode: nameRoute,
                    controller: nameRouteEC,
                    decoration: const InputDecoration(
                      labelText: 'Rota da pagina',
                      icon: Icon(Icons.apps_outage),
                    ),
                    validator: (values) {
                      final String value = values ?? '';
                      if (value.trim().isEmpty) {
                        return 'O campo deve ser prenchido.';
                      }
                      return null;
                    },
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
            StatefulBuilder(
              builder: (context, setState) {
                return isLoading
                    ? LoadingAnimationWidget.fourRotatingDots(
                        color: Colors.white,
                        size: 60,
                      )
                    : TextButton(
                        child: const Text("Salvar"),
                        onPressed: () async {
                          final isValid =
                              formKey.currentState?.validate() ?? false;
                          if (isValid) {
                            selectedIcon ??= Icons.fact_check;
                            final newActivities = Activity(
                              name: nameActivityEC.text,
                              page: nameRouteEC.text,
                              icon: selectedIcon,
                            );

                            // Se o formulário for válido HABILITA o CircularProgressIndicator passando
                            // o isLoading para true.
                            setState(() {
                              if (isValid) isLoading = true;
                            });

                            FirebaseFirestore firestore =
                                FirebaseFirestore.instance;
                            Map<String, dynamic> activityData =
                                newActivities.toMap();
                            await firestore
                                .collection('departaments')
                                .doc(widget.departaments.id)
                                .update({
                              'activity': FieldValue.arrayUnion([activityData])
                            });
                            // Se o formulário for válido DESABILITA o CircularProgressIndicator
                            Navigator.pop(context);
                            setState(() {
                              if (isValid) isLoading = false;
                            });
                            getData();
                          }
                        });
              },
            ),
            TextButton(
                child: const Text("Calcelar"),
                onPressed: () async {
                  selectedIcon = null;
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  dialog(){
    return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Tem certeza'),
            content: const Text('Quer remover os itens?'),
            actions: [
              TextButton(
                child: const Text('Sim'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: const Text('Não'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    final isDark = Provider.of<AppTheme>(
      context,
    ).isDark();
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double scaleFactor = constraints.maxWidth / 100;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Menu de atividades '),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 900),
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
                              child: Container(
                                constraints:
                                    const BoxConstraints(minWidth: 900),
                                decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.2),
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100),
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 40, top: 5, bottom: 5),
                                  child: Text(
                                    widget.departaments.name.toUpperCase(),
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                ),
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
                                    child:
                                        Text("Lista de menus das atividades"),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: (listActivities.isEmpty)
                        ? LoadingAnimationWidget.fourRotatingDots(
                            color: Colors.white.withOpacity(0.5), size: 120)
                        : Container(
                            constraints: const BoxConstraints(maxWidth: 900),
                            child: Card(
                              shadowColor: Colors.black,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: listActivities.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shadowColor: Colors.black,
                                      elevation: 9,
                                      color: const Color.fromARGB(
                                          255, 130, 131, 134),
                                      surfaceTintColor: Colors.amber[200],
                                      child: Dismissible(
                                        key: ValueKey(listActivities),
                                        direction: DismissDirection.endToStart,
                                        background: Container(
                                          alignment: Alignment.centerRight,
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          color: Colors.red,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 4),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                        onDismissed: (context) {},
                                        child: ListTile(
                                            leading: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Icon(
                                                  listActivities[index].icon),
                                            ),
                                            title: Text(
                                                listActivities[index].name),
                                            subtitle: Text(
                                                listActivities[index].page),
                                            hoverColor: Colors.deepOrange,
                                            onTap: () {
                                              //TODO Implementatar aqui o dismisible, remove!
                                            }),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(
              right: isDesktop ? scaleFactor * 25 : scaleFactor * 5.5,
              bottom: isDesktop ? scaleFactor * 1.3 : scaleFactor * 5,
            ),
            child: SizedBox(
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  createType(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
