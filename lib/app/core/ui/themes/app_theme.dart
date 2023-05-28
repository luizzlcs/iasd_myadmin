import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  late ThemeData _myTheme = _darkTheme;

  ThemeData get myTheme {
    return _myTheme;
  }

  bool isDark() {
    if (_myTheme == _darkTheme) {
      return true;
    } else {
      return false;
    }
  }

  final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme:  const IconThemeData(size: 25, color:  Colors.red),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white, fontStyle: FontStyle.italic, fontSize: 15),
      headlineMedium: TextStyle(
          color: Color.fromARGB(250, 26, 35, 126),
          fontWeight: FontWeight.bold,
          fontSize: 40),
    ),
  );

  final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: const IconThemeData(size: 25, color: Colors.blue),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.black, fontStyle: FontStyle.italic, fontSize: 15),
      headlineMedium: TextStyle(
          color: Color.fromARGB(250, 26, 35, 126),
          fontWeight: FontWeight.bold,
          fontSize: 40),
    ),
  );

  void changMode() {
    if (_myTheme == _darkTheme) {
      _myTheme = _lightTheme;
    } else {
      _myTheme = _darkTheme;
    }
    notifyListeners();
  }
}
