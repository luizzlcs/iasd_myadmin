import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/dashboard/components/app_drawer.dart';
import 'package:iasd_myadmin/app/pages/dashboard/components/grid_departaments.dart';
import 'package:iasd_myadmin/app/core/ui/themes/app_theme.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:iasd_myadmin/app/core/util/controller_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'components/dialogo_user_data.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List disposable = [];

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
  void openPage(BuildContext context){
    Navigator.of(context).pushNamed(AppRoutes.pefilUser);
  }

  Future<void> loginOut() async {
    await FirebaseAuth.instance.signOut();
    debugPrint('Abrindo página');
  }

  void createType(context) async {
    final isDark = Provider.of<AppTheme>(context, listen: false).isDark();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController namePersonEC = TextEditingController();
    TextEditingController emailEC = TextEditingController();
    FocusNode nameRoute = FocusNode();
    bool isLoading = false;

    disposable.add(namePersonEC);
    disposable.add(emailEC);
    disposable.add(nameRoute);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('DADOS DO USUÁRIO'),
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
                    controller: namePersonEC,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Nome do usuário',
                      icon: Icon(Icons.person),
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
                    controller: emailEC,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      icon: Icon(Icons.email),
                    ),
                    validator: (values) {
                      final String value = values ?? '';
                      if (value.trim().isEmpty) {
                        return 'O campo deve ser prenchido.';
                      }
                      return null;
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(5)),
                  StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Column(children: []);
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
                            // Se o formulário for válido HABILITA o CircularProgressIndicator passando
                            // o isLoading para true.
                            setState(() {
                              if (isValid) isLoading = true;
                            });

                            // Se o formulário for válido DESABILITA o CircularProgressIndicator
                            Navigator.pop(context);
                            setState(() {
                              if (isValid) isLoading = false;
                            });
                          }
                        });
              },
            ),
            TextButton(
                child: const Text("Calcelar"),
                onPressed: () async {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<AppTheme>(context, listen: false).isDark();
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
                        children: [
                          Icon(
                            Icons.brightness_5_outlined,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          const Text(' Modo Claro'),
                        ],
                      )
                    : Row(
                        children: [
                          Icon(
                            Icons.brightness_3,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          const Text(' Modo Escuro  '),
                        ],
                      ),
              ),
              PopupMenuItem(
                onTap: (){
                  // showCustomDialog(context);
                  openPage(context);
                  print('não sei o que está acontecendo');
                },
                value: 2,
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const Text(' Perfil do usuário'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const Text(' Configuações'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    const Text(' Sair'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              setState(() {
                if (value == 1) {
                  Provider.of<AppTheme>(context, listen: false).chandMode();
                  ControllerTheme.instance.changeTheme();
                } else if (value == 4) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login, (route) => false);
                  loginOut();
                }
              });
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: const GridDepartaments(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final user = await FirebaseAuth.instance.currentUser;
              if (user != null) {
                // Name, email address, and profile photo URL
                final name = user.displayName;
                final email = user.email;
                final photoUrl = user.photoURL;
                debugPrint('NOME:$name');
                debugPrint('E-MAIL:$email');

                
                debugPrint('${user.emailVerified}');

                final uid = user.uid;
              }
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () async {
              Navigator.of(context).pushNamed(AppRoutes.pefilUser);
              // showCustomDialog(context);
            },
            child: const Icon(Icons.format_align_center),
          ),
        ],
      ),
    );
  }
}
