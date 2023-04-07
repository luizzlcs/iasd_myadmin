import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/components/background.dart';
import 'package:iasd_myadmin/app/screens/login/components/sing_up_top_image.dart';
import 'package:iasd_myadmin/app/screens/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/util/responsive.dart';
import 'package:provider/provider.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              Expanded(
                child: Provider.of<ControllerAlthLogin>(context).isLogin()
                    ? const LoginScreenTopImage()
                    : const SignUpScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: LoginForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Provider.of<ControllerAlthLogin>(context).isLogin()
            ? const LoginScreenTopImage()
            : const SignUpScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
