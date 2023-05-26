import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  youDialogin() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 4,
          title: const Text(
            'Deseja sair do sistema?',
            style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Não',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                'Sim',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              onPressed: () async {},
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      child: Column(
        children: [
          AppBar(
            title: const Text('Seja Bem Vindo!'),
            actions: [
              TextButton(
                onPressed: () {
                  youDialogin();
                },
                child: const Text('Editar'),
              )
            ],
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dashboard_customize_sharp),
            title: const Text('PAINEL'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.dashBoard);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.now_widgets_rounded),
            title: const Text(' Novo Departamento'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.listDepartament);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dataset_rounded),
            title: const Text('Atividade sem Página'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              // Navigator.of(context).pushNamed('nova');
            },
          ),
        ],
      ),
    );
  }
}
