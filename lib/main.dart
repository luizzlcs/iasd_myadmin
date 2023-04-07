import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/model/departaments/departaments_controller.dart';
import 'package:iasd_myadmin/app/screens/departaments/secretaria/secretaria_screen.dart';
import 'package:iasd_myadmin/app/screens/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/screens/login/login_screen.dart';
import 'package:iasd_myadmin/app/themes/app_theme.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';
import 'package:provider/provider.dart';

import 'app/screens/dashboard/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DepartamentsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ControllerAlthLogin(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppTheme(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<AppTheme>(context).myTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.dashBoard: (_) => const DashboardScreen(),
        AppRoutes.secretaria: (_) => const SecretariaScreen(),
      },
    );
  }
}
