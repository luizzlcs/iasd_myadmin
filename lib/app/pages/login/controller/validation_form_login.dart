// import 'package:iasd_myadmin/app/util/email_validator_util.dart' as EmailValid;

import 'package:iasd_myadmin/app/core/util/email_validator_util.dart' as email_valid;

mixin ValidationFormLogin {
  bool isValidPassword(String? value) => value != null && value.length >= 6;

  bool isValidPasswordCofirmation(String? value, String confirmPassword) {
    if (value == confirmPassword) {
      return true;
    }
    return false;
  }

  bool isValidEmail(String? email) {
    if (email_valid.isValid(email!.trim())) {
      return true;
    }
    return false;
  }
}
