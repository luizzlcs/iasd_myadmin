import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';

enum AuthMode { signup, login }

class ControllerAlthLogin with ChangeNotifier {
  var authMode = AuthMode.login;

  bool isLogin() => authMode == AuthMode.login;
  bool isSignup() => authMode == AuthMode.signup;

  swichAlthMode() {
    if (isLogin() == true) {
      authMode = AuthMode.signup;
      notifyListeners();
    } else {
      authMode = AuthMode.login;
      notifyListeners();
    }
    debugPrint('FLUTTER 4.5: $authMode');
    notifyListeners();
  }
}