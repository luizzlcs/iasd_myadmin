// import 'package:iasd_myadmin/app/util/email_validator_util.dart' as EmailValid;

import 'package:iasd_myadmin/app/util/email_validator_util.dart' as EmailValid;

mixin ValidationFormLogin {
  bool isValidPassword(String? value) => value != null && value.length >= 6;
  

 bool isValidEmail(String? email) {
    if (EmailValid.isValid(email)) {
      return true;
    }
    return false;
  } 
}
