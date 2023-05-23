import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/login/components/already_have_an_account_acheck.dart';
import 'package:iasd_myadmin/app/pages/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/pages/login/controller/validation_form_login.dart';
import 'package:iasd_myadmin/app/exceptions/auth_exception.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:iasd_myadmin/app/core/global/constants.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../exceptions/firebase_login_exception.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with ValidationFormLogin {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _buttonLoginFocus = FocusNode();
  bool _passwordsMatch = false;
  bool _obscureText = true;
  bool _isLoading = false;
  final FocusNode _loginFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _loginFocus.requestFocus();
    });
    _passwordEC.addListener(_checkPasswordsMatch);
    _confirmPasswordEC.addListener(_checkPasswordsMatch);
    super.initState();
  }

  @override
  void dispose() {
    _loginFocus.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  void _checkPasswordsMatch() {
    setState(() {
      _passwordsMatch = _passwordEC.text == _confirmPasswordEC.text;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um erro!'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('Fechar'),
          )
        ],
      ),
    );
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
          email: _emailEC.text,
          password: _passwordEC.text,
        );

        if (credential != null && credential.user?.emailVerified == true) {
          pageDashBoard();
        } else {
          setState(() {
            _isLoading = false;
          });

          snackBar(
            menssage: const Text('O e-mail digitado ainda não foi confirmado!'),
            text: 'Reenviar ',
            onPressed: () {
              credential.user?.sendEmailVerification();
            },
          );
        }
      }
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
          _isLoading = false;
        });
          _showErrorDialog('Usuário não encontrado!');
        } else if (e.code == 'wrong-password') {
          setState(() {
          _isLoading = false;
        });
         _showErrorDialog('Parece que a senha não está correta!');
        }else if(e.code == 'user-disabled'){
          setState(() {
          _isLoading = false;
        });
          _showErrorDialog('O e-mail fornecido está desabilitado!');
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
              if (isValidEmail(value)) {
                return null;
              }
              return 'O email não é válido';
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
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
              },
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
                          icon: const Icon(
                            Icons.close,
                            color: Color.fromARGB(255, 117, 40, 34),
                          ),
                        ),
                ),
              ),
            ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: _isLoading
                ? loadingAnimated()
                : ElevatedButton(
                    focusNode: _buttonLoginFocus,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(250, 40)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          if (isLogin != true) {
                            //TODO implement here!
                            // await auth.singUp(_emailEC.text, _passwordEC.text);
                            registerUser();
                          } else {
                            loginUser();
                            /* Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.dashBoard); */
                            // await auth.login(_emailEC.text, _passwordEC.text);
                          }
                          if (!mounted) return;
                        } on AuthException catch (error) {
                          _showErrorDialog(error.toString());
                          setState(() {
                            _isLoading = false;
                          });
                        } catch (error) {
                          _showErrorDialog('ocorreu um erro inesperado');
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    child: Text(
                      isLogin
                          ? "Login".toUpperCase()
                          : 'Criar conta'.toUpperCase(),
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
