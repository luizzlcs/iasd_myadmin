import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/dashboard/components/app_drawer.dart';
import 'package:iasd_myadmin/app/pages/dashboard/components/grid_departaments.dart';
import 'package:iasd_myadmin/app/core/ui/themes/app_theme.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:iasd_myadmin/app/core/util/controller_theme.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

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

  void openPage(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.pefilUser);
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void exitDialog() {
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
              onPressed: () async {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
                logOut();
              },
            ),
          ],
        );
      },
    );
  }

  void createType(context) async {
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
                    return Column(children: const []);
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
    final user = FirebaseAuth.instance.currentUser;

    var photoURL = user?.photoURL ??
        'https://tm.ibxk.com.br/2017/06/22/22100428046161.jpg';
    final isDark = Provider.of<AppTheme>(context, listen: false).isDark();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Painel Administrativo'),
        ),
        actions: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              maxRadius: 25,
              backgroundImage: ResizeImage(NetworkImage(photoURL.toString()),
                  width: 90, height: 90),
            ),
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  changeBrightness();
                },
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
                  Provider.of<AppTheme>(context, listen: false).changMode();
                  ControllerTheme.instance.changeTheme();
                } else if (value == 4) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login, (route) => false);
                  logOut();
                } else if (value == 2) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.pefilUser, (route) => false);
                }
              });
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: const GridDepartaments(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          exitDialog();
        },
        child: const Icon(Icons.settings_power_outlined),
      ),
    );
  }
}
