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
  bool _passwordsMatch = false;
  bool _obscureText = true;

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    _passwordEC.addListener(_checkPasswordsMatch);
    _confirmPasswordEC.addListener(_checkPasswordsMatch);
    super.initState();
  }

  void _checkPasswordsMatch() {
    setState(() {
      _passwordsMatch = _passwordEC.text == _confirmPasswordEC.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = Provider.of<ControllerAlthLogin>(context).isLogin();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailEC,
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
            decoration: InputDecoration(
              hintText: "Seu e-mail",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
              suffixIcon: IconButton(
                onPressed: () => _emailEC.clear(),
                icon: const Icon(Icons.backspace),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _passwordEC,
              validator: (value) {
                if (isValidPassword(value)) {
                  return null;
                }
                return 'Você precisa digitar no minimo 6 caracteres';
              },
              textInputAction: TextInputAction.done,
              obscureText: _obscureText,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Sua senha",
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: _obscureText
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
            ),
          ),
          if (Provider.of<ControllerAlthLogin>(context).isSignup())
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                controller: _confirmPasswordEC,
                validator: (value) {
                  if (isValidPasswordCofirmation(value, _passwordEC.text)) {
                    debugPrint('PASSWORD: ${_passwordEC.text}');
                    debugPrint('CONFIRMAÇÃO: $value');
                    return null;
                  }
                  debugPrint('PASSWORD: ${_passwordEC.text}');
                  debugPrint('CONFIRMAÇÃO: $value');
                  return 'As senhas são diferentes';
                },
                textInputAction: TextInputAction.done,
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Confirme sua senha",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: _passwordsMatch
                      ? const Icon(Icons.check, color: Colors.green)
                      : IconButton(
                          onPressed: () => _confirmPasswordEC.clear(),
                          icon: const Icon(Icons.close, color: Colors.red)),
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
