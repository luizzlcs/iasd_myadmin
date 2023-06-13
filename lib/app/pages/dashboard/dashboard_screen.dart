import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iasd_myadmin/app/core/ui/styles/colors_app.dart';
import 'package:iasd_myadmin/app/pages/dashboard/components/app_drawer.dart';
import 'package:iasd_myadmin/app/pages/dashboard/components/grid_departaments.dart';
import 'package:iasd_myadmin/app/core/ui/themes/app_theme.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:iasd_myadmin/app/core/util/controller_theme.dart';
import 'package:iasd_myadmin/app/pages/dashboard/testes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:new_keyboard_shortcuts/keyboard_shortcuts.dart';
import 'components/storage.dart';

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
  imageDialogin(String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          title: Column(
            children: [
              SizedBox(
                width: 300,
                height: 300,
                child: Image.network(fit: BoxFit.cover, url.toString()),
              )
            ],
          ),
        );
      },
    );
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
            'Deslogar',
            style: TextStyle(
              fontSize: 22,
              color: Color.fromARGB(255, 40, 3, 141),
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                    color: Colors.black12,
                    blurRadius: 0.0,
                    offset: Offset.infinite),
                Shadow(color: Colors.deepOrange),
                Shadow(
                    color: Colors.deepPurple,
                    blurRadius: 0.0,
                    offset: Offset.infinite),
              ],
            ),
          ),
          content: const Text(
            'Tem certeza que deseja sair?',
            style: TextStyle(color: Color.fromARGB(255, 79, 186, 248)),
          ),
          actions: [
            KeyBoardShortcuts(
              keysToPress: {LogicalKeyboardKey.keyN},
              onKeysPressed: () => Navigator.of(context).pop(),
              child: TextButton(
                child: RichText(
                  text: const TextSpan(
                    text: '',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'N',
                        style: TextStyle(
                            color: Color.fromARGB(255, 40, 37, 41),
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'ão'),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            KeyBoardShortcuts(
              keysToPress: {LogicalKeyboardKey.keyS},
              onKeysPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
                logOut();
              },
              child: TextButton(
                child: RichText(
                  text: const TextSpan(text: '', children: [
                    TextSpan(
                      text: 'S',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 40, 37, 41),
                      ),
                    ),
                    TextSpan(
                      text: 'im',
                      style: TextStyle(
                        color: Color.fromARGB(255, 40, 37, 41),
                      ),
                    ),
                  ]),
                ),
                onPressed: () async {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login, (route) => false);
                  logOut();
                },
              ),
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
          GestureDetector(
            onTap: () => imageDialogin(photoURL),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: ResizeImage(NetworkImage(photoURL.toString()),
                    width: 90, height: 90),
              ),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          FloatingActionButton(
            backgroundColor: Colors.green[700],
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  const Testes()//const TaskManager(),
              ));
            },
            
            child: const Icon(
              Icons.table_rows,
              color: Colors.black,
            ),
          ),
          FloatingActionButton(
            backgroundColor: context.colors.secundary,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>  const TaskManager(),
              ));
            },
            
            child: const Icon(
              Icons.image_search,
              color: Colors.black,
            ),
          ),
          KeyBoardShortcuts(
            keysToPress:{LogicalKeyboardKey.keyS},
            onKeysPressed: () => exitDialog(),
            child: FloatingActionButton(
              onPressed: () {
                exitDialog();
              },
              child: const Icon(Icons.settings_power_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
