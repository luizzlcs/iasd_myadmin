import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/login/components/background.dart';
import 'package:iasd_myadmin/app/pages/login/components/app_bar/app_bar_mobile.dart';
import 'package:iasd_myadmin/app/pages/login/components/app_bar/app_bar_web.dart';
import 'package:iasd_myadmin/app/pages/login/components/app_bar/app_drawer_login.dart';
import 'package:iasd_myadmin/app/pages/login/components/sign_up_form.dart';
import 'package:iasd_myadmin/app/pages/login/components/sing_up_top_image.dart';
import 'package:iasd_myadmin/app/core/util/responsive.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 56),
            child: constraints.maxWidth <= 650
                ? const AppBarMobile()
                : const AppBarWeb(),
          ),
          endDrawer:
              (constraints.maxWidth < 650) ? const AppDrawerLogin() : null,
          body: Background(
            child: SingleChildScrollView(
              child: Responsive(
                mobile: const MobileSignUpScreen(),
                desktop: Row(
                  children: [
                    const Expanded(
                      child: SignUpScreenTopImage(),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 450,
                            child: SignUpForm(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MobileSignUpScreen extends StatelessWidget {
  const MobileSignUpScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
