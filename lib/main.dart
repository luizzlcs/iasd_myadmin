import 'package:flutter/material.dart';
import 'package:iasd_myadmin/model/departaments/departaments_controller.dart';
import 'package:iasd_myadmin/screens/dashboard/dashboard_screen.dart';
import 'package:iasd_myadmin/screens/departaments/secretaria/secretaria_screen.dart';
import 'package:iasd_myadmin/screens/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/screens/login/login_screen.dart';
import 'package:iasd_myadmin/util/app_routes.dart';
import 'package:iasd_myadmin/util/controller_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DepartamentsController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ControllerAlthLogin(),
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
    return AnimatedBuilder(
      animation: ControllerTheme.instance,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            brightness: ControllerTheme.instance.isDarkTheme
                ? Brightness.light
                : Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            AppRoutes.login: (_) => const LoginScreen(),
            AppRoutes.dashBoard: (_) => const DashboardScreen(),
            AppRoutes.secretaria: (_) => const SecretariaScreen(),
          },
        );
      },
    );
  }
}
