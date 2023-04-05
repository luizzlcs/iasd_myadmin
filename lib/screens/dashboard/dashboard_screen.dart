import 'package:flutter/material.dart';
import 'package:iasd_myadmin/components/app_drawer.dart';
import 'package:iasd_myadmin/components/grid_departaments.dart';
import 'package:iasd_myadmin/util/app_routes.dart';
import 'package:iasd_myadmin/util/controller_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var brightness = 1;

  void changeBrightness() {
    setState(() {
      if (brightness == 1) {
        brightness = 0;
      } else {
        brightness = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Painel Administrativo'),
        ),
        actions: [
          const CircleAvatar(
            backgroundImage: ResizeImage(
                NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwmc918DMjmBUacqi3u-YdsSta_LMyow19hDiwIxRrgZEwkbkUfZLB1tw2FTwz-CI1rQ8&usqp=CAU'),
                width: 160,
                height: 160),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: brightness == 1
                    ? Row(
                        children: const [
                          Icon(
                            Icons.brightness_5_outlined,
                            color: Colors.white,
                          ),
                          Text(' Modo Claro')
                        ],
                      )
                    : Row(
                        children: const [
                          Icon(
                            Icons.brightness_3,
                            color: Colors.black,
                          ),
                          Text(' Modo Escuro  ')
                        ],
                      ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.person),
                    Text(' Perfil do usuário'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: const [
                    Icon(Icons.settings),
                    Text(' Configuações'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    Text(' Sair'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              setState(() {
                if (value == 1) {
                  changeBrightness();
                  ControllerTheme.instance.changeTheme();
                } else if (value == 4) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login, (route) => false);
                }
              });
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: const GridDepartaments(),
    );
  }
}
