import 'package:flutter/material.dart';

enum AuthMode { signup, login }

class ControllerAlthLogin with ChangeNotifier {
  var authMode = AuthMode.login;

  isLogin() => authMode == AuthMode.login;
  isSignup() => authMode == AuthMode.signup;

  swichAlthMode() {
    if (isLogin() == true) {
      authMode = AuthMode.signup;
      notifyListeners();
    } else {
      authMode = AuthMode.login;
      notifyListeners();
    }
    print('FLUTTER 4.5: $authMode');
    notifyListeners();
  }
}