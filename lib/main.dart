import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/core/secretaria/screens/navegacao.dart';
import 'package:iasd_myadmin/app/core/secretaria/screens/secretary_screen.dart';
import 'package:iasd_myadmin/app/core/login/model/auth.dart';
import 'package:iasd_myadmin/app/core/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/core/login/screen/login_screen.dart';
import 'package:iasd_myadmin/app/themes/app_theme.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';
import 'package:provider/provider.dart';
import 'app/components/page_constrution.dart';
import 'app/core/dashboard/dashboard_screen.dart';
import 'app/core/departament/list_departamets_screen.dart';

Future<void> main() async {
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
        ),
      ],
      child: const MyApp(),
      
    ),
  );

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseFirestore.instance.collection('client').doc().set({
  'name': 'Lucicleide',
  'phone': '84988975886',
  'email': 'cleidinha_amore@gmail.com'
});
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
        title: 'MyAdmin7',
        theme: Provider.of<AppTheme>(context).myTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.login: (_) => const LoginScreen(),
          AppRoutes.dashBoard: (_) => const DashboardScreen(),
          AppRoutes.secretaria: (_) => const SecretaryScreen(),
          AppRoutes.navegacao: (_) => const Navegacao(),
          AppRoutes.listDepartament: (_) => const ListDepartamentScreen(),
          AppRoutes.pageConstrution: (_) => const PageConstrution(),
        },
      ),
    );
  }
}
