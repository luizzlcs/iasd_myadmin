import 'package:firebase_core/firebase_core.dart';
import 'app/pages/dashboard/components/scren_user_data.dart';
import 'app/pages/login/sign_up_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/departament/controllers/departaments_controller.dart';
import 'package:iasd_myadmin/app/pages/secretaria/navegacao.dart';
import 'package:iasd_myadmin/app/pages/secretaria/secretary_screen.dart';
import 'package:iasd_myadmin/app/pages/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/pages/login/login_screen.dart';
import 'package:iasd_myadmin/app/core/ui/themes/app_theme.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:provider/provider.dart';
import 'app/core/ui/components/page_constrution.dart';
import 'app/pages/dashboard/dashboard_screen.dart';
import 'app/pages/departament/list_departamets_screen.dart';

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
        
      ],
      child: const MyApp(),
      
    ),
  );

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
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
          AppRoutes.pefilUser: (_) => const ScrenUserData(),
          AppRoutes.signUpScreen: (_) => const SignUpScreen(),
        },
      ),
    );
  }
}
