import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';

class AppDrawerLogin extends StatelessWidget {
  const AppDrawerLogin({Key? key}) : super(key: key);

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
            leading: const Icon(Icons.diversity_3),
            title: const Text('QUEM SOMOS'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.pageConstrution);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.import_contacts),
            title: const Text('NOSSAS CRENÇAS'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.pageConstrution);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text('CONTATENOS'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.pageConstrution);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('ONDE ESTAMOS'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.pageConstrution);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.event_available),
            title: const Text('NOSSA AGENDA'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.pageConstrution);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.wb_twilight),
            title: const Text('POR DO SOL'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.pageConstrution);
            },
          ),
          
          
        ],
      ),
    );
  }
}
