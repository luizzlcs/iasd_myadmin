import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/core/login/model/auth.dart';
import 'package:iasd_myadmin/app/core/secretaria/screens/secretaria_screen.dart';
import 'package:iasd_myadmin/app/core/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/core/login/screen/login_screen.dart';
import 'package:iasd_myadmin/app/themes/app_theme.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';
import 'package:provider/provider.dart';

import 'app/core/dashboard/dashboard_screen.dart';

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
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        theme: Provider.of<AppTheme>(context).myTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.login: (_) => const LoginScreen(),
          AppRoutes.dashBoard: (_) => const DashboardScreen(),
          AppRoutes.secretaria: (_) => const SecretariaScreen(),
        },
      ),
    );
  }
}
