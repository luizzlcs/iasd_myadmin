import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/components/already_have_an_account_acheck.dart';
import 'package:iasd_myadmin/app/screens/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/screens/login/controller/validation_form_login.dart';
import 'package:iasd_myadmin/app/util/app_routes.dart';
import 'package:iasd_myadmin/app/util/constants.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with ValidationFormLogin {
  final _formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isLogin = Provider.of<ControllerAlthLogin>(context).isLogin();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailEC,
            validator: (value) {
              if (isValidEmail(value)) {
                return null;
              }
              return 'O email não é válido';
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Seu e-mail",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordEC,
              validator: (value) {
                if (isValidPassword(value)) {
                  return null;
                }
                return 'Você precisa digitar no minimo 6 caracteres';
              },
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Sua senha",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          if (Provider.of<ControllerAlthLogin>(context).isSignup())
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: const InputDecoration(
                  hintText: "Confirme sua senha",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
            ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(fixedSize: const Size(250, 40)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.dashBoard, (route) => false);
                }
              },
              child: Text(
                isLogin ? "Login".toUpperCase() : 'Criar conta'.toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {},
          ),
        ],
      ),
    );
  }
}
