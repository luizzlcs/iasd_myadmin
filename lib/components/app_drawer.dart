import 'package:flutter/material.dart';
import 'package:iasd_myadmin/util/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 230,
      child: Column(
        children: [
          AppBar(
            title: const Text('Seja Bem Vindo!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dashboard_customize_sharp),
            title: const Text('Painel'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.dashBoard);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.message_rounded),
            title: const Text(' Envio de Mensagens'),
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
