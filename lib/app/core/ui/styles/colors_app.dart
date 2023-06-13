import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;
  // Avoid self instance
  ColorsApp._();
  static ColorsApp get instance{
    _instance??=  ColorsApp._();
    return _instance!;
   }

   Color get primary => const Color(0XFF007D21);
   Color get secundary => const Color(0XFFFFAB18);
   Color get black => const Color(0XFF140E0E);
}

extension ColorAppExtension on BuildContext{
  ColorsApp get colors => ColorsApp.instance;
}