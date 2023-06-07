import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/core/ui/helpers/messages.dart';
import 'package:iasd_myadmin/app/pages/login/components/already_have_an_account_acheck.dart';
import 'package:iasd_myadmin/app/pages/login/components/social_button.dart';
import 'package:iasd_myadmin/app/pages/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/pages/login/controller/validation_form_login.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:iasd_myadmin/app/core/global/constants.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with ValidationFormLogin, Messagens {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _buttonLoginFocus = FocusNode();
  bool _obscureText = true;
  bool _isLoading = false;
  final FocusNode _loginFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _loginFocus.requestFocus();
    });
    super.initState();
  }

  @override
  void dispose() {
    _loginFocus.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  Widget loadingAnimated() {
    return LoadingAnimationWidget.fourRotatingDots(
      color: Colors.white.withOpacity(0.5),
      size: 120,
    );
  }

  Future<void> registerUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailEC.text,
      password: _passwordEC.text,
    );
  }

  void pageDashBoard() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.dashBoard);
  }

  void snackBar(
      {required Widget menssage,
      required String text,
      required VoidCallback onPressed}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        content: menssage,
        action: SnackBarAction(label: text, onPressed: onPressed),
      ),
    );
  }

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailEC.text.trim(),
          password: _passwordEC.text.trim(),
        );

        if (credential != null && credential.user?.emailVerified == true) {
          pageDashBoard();
        } else {
          setState(() {
            _isLoading = false;
          });

          snackBar(
            menssage: const Text(
                'O e-mail digitado ainda não foi confirmado, verifique sua caixa de e-mail!'),
            text: 'Reenviar confirmação',
            onPressed: () {
              credential.user?.sendEmailVerification();
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          setState(() {
            _isLoading = false;
          });
          showInfo('O formato de e-mail digitado não está correto!');
        }
        if (e.code == 'user-not-found') {
          setState(() {
            _isLoading = false;
          });
          showError(
            'Usuário não encontrado!',
          );
        } else if (e.code == 'wrong-password') {
          setState(() {
            _isLoading = false;
          });
          showWarning('Parece que a senha não está correta!');
        } else if (e.code == 'user-disabled') {
          setState(() {
            _isLoading = false;
          });
          showInfo('O e-mail fornecido está desabilitado!');
        }
      }
    }
  }

  Future<void> signInUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailEC.text,
      password: _passwordEC.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final Auth auth = Provider.of(context, listen: false);
    final isLogin = Provider.of<ControllerAlthLogin>(context).isLogin();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailEC,
            focusNode: _loginFocus,
            validator: (value) {
              final values = value ?? '';
              final values2 = values.trim().replaceAll(RegExp(r'\s+$'), '');
              if (isValidEmail(values2)) {
                return null;
              }
              return 'O email não é válido';
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSaved: (email) {},
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocus);
            },
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
              focusNode: _emailFocus,
              onFieldSubmitted: (_) async {
                FocusScope.of(context).requestFocus(_buttonLoginFocus);
                loginUser();
              },
              validator: (value) {
                if (isValidPassword(value)) {
                  return null;
                }
                return 'Você precisa digitar no minimo 6 caracteres';
              },
              textInputAction: TextInputAction.done,
              obscureText: _obscureText,
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
          const SizedBox(height: defaultPadding),
          _isLoading
              ? loadingAnimated()
              : ElevatedButton(
                  focusNode: _buttonLoginFocus,
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(250, 40)),
                  onPressed: () async {
                    loginUser();
                  },
                  child: Text(
                    'Login'.toUpperCase(),
                  ),
                ),
          const SizedBox(height: defaultPadding),
          const SocialButton(),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {},
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
