import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/activity_form_screen.dart';
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';
import 'package:provider/provider.dart';

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
                            borderRadius: BorderRadius.circular(100)

                            ),
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
                            widget.departaments.removActivity(index);
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ActivityFormScreen()),
          ).then((newActivity) {
            if (newActivity != null) {
              Provider.of<DepartamentsController>(context, listen: false)
                  .addActivity(newActivity, widget.index);
              /* setState(() {
                widget.departaments.activity.add(newActivity);
              }); */
            }
          });
        },
      ),
    );
  }
}
