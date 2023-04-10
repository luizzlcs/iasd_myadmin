// import 'package:iasd_myadmin/app/util/email_validator_util.dart' as EmailValid;

import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/util/email_validator_util.dart' as EmailValid;

mixin ValidationFormLogin{
  bool isValidPassword(String? value) => value != null && value.length >= 6;

  bool isValidPasswordCofirmation(
      String? value, String confirmPassword) {
    if (value == confirmPassword) {
      return true;
    }
    return false;
  }

  bool isValidEmail(String? email) {
    if (EmailValid.isValid(email)) {
      return true;
    }
    return false;
  }
}
