import 'package:flutter/material.dart';

class ControllerTheme extends ChangeNotifier {
  static ControllerTheme instance = ControllerTheme();
  
  bool isDarkTheme = false;

  changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
