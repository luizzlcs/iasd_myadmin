import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iasd_myadmin/app/pages/login/components/already_have_an_account_acheck.dart';
import 'package:iasd_myadmin/app/pages/login/controller/controller_alth_login.dart';
import 'package:iasd_myadmin/app/pages/login/controller/validation_form_login.dart';
import 'package:iasd_myadmin/app/core/util/app_routes.dart';
import 'package:iasd_myadmin/app/core/global/constants.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with ValidationFormLogin {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordConfirm = FocusNode();
  final FocusNode _buttonCreateCountFocus = FocusNode();
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
    _buttonCreateCountFocus.dispose();
    _passwordConfirm.dispose();
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

  void pageLogin() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  void snackBar({required Widget menssage}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: menssage,
        duration: const Duration(seconds: 10),
        backgroundColor: Colors.deepOrange,
        showCloseIcon: true,
      ),
    );
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailEC.text.trim(),
          password: _passwordEC.text.trim(),
        );

        credential.user?.sendEmailVerification();
        pageLogin();
        {
          setState(() {
            _isLoading = false;
          });

          snackBar(
            menssage: const Text(
                'Foi enviado um e-mail de confirmação, verifique sua caixa de e-mail'),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'operation-not-allowed') {
          setState(() {
            _isLoading = false;
          });
          _showErrorDialog(
              'Já existe uma conta com este e-mail, só que está desabilitada, contate o administrador do MyAdmin7!');
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _isLoading = false;
          });
        }
        _showErrorDialog(
            'Já existe uma conta com o endereço de e-mail informado!');
        if (e.code == 'invalid-email') {
          setState(() {
            _isLoading = false;
          });
          _showErrorDialog(
              'O endereço de e-mail informado não é válido, verifique se existe algum caracte fora do padrão de e-mail!');
        } else if (e.code == 'weak-password') {
          setState(() {
            _isLoading = false;
          });
          _showErrorDialog('Você precisa digitar pelo menos 6 caracteres!');
        }
      }
    }
  }

 
  @override
  Widget build(BuildContext context) {
    // final isLogin = Provider.of<ControllerAlthLogin>(context).isLogin();

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
                FocusScope.of(context).requestFocus(_passwordConfirm);
              },
              validator: (value) {
                if (isValidPassword(value)) {
                  return null;
                }
                return 'Você precisa digitar no minimo 6 caracteres';
              },
              textInputAction: TextInputAction.next,
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
          if (Provider.of<ControllerAlthLogin>(context).isSignup())
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
                controller: _confirmPasswordEC,
                focusNode: _passwordConfirm,
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
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_buttonCreateCountFocus);
                  registerUser();
                },
              ),
            ),
          const SizedBox(height: defaultPadding),
          _isLoading
              ? loadingAnimated()
              : ElevatedButton(
                  focusNode: _buttonCreateCountFocus,
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(250, 40)),
                  onPressed: () async {
                    registerUser();
                  },
                  child: Text(
                    'Criar conta'.toUpperCase(),
                  ),
                ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
               
              },
              child: const Text('Google')),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {},
          ),
        ],
      ),
    );
  }
}
