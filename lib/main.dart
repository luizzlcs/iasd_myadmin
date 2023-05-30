import 'package:firebase_core/firebase_core.dart';
import 'app/pages/dashboard/components/not_found_page.dart';
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
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.login:
              return MaterialPageRoute(builder: (_) => const LoginScreen());
            case AppRoutes.dashBoard:
              return MaterialPageRoute(builder: (_) => const DashboardScreen());
            case AppRoutes.secretaria:
              return MaterialPageRoute(builder: (_) => const SecretaryScreen());
            case AppRoutes.navegacao:
              return MaterialPageRoute(builder: (_) => const Navegacao());
            case AppRoutes.listDepartament:
              return MaterialPageRoute(
                  builder: (_) => const ListDepartamentScreen());
            case AppRoutes.pageConstrution:
              return MaterialPageRoute(builder: (_) => const PageConstrution());
            case AppRoutes.pefilUser:
              return MaterialPageRoute(builder: (_) => const ScrenUserData());
            case AppRoutes.signUpScreen:
              return MaterialPageRoute(builder: (_) => const SignUpScreen());
            default:
              return MaterialPageRoute(builder: (_) => const NotFoundPage());
          }
        },
      ),
    );
  }
}
