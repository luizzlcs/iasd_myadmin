import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iasd_myadmin/app/core/ui/helpers/messages.dart';


import '../../../core/util/app_routes.dart';

class SocialButton extends StatefulWidget {
  const SocialButton({Key? key}) : super(key: key);

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> with Messagens {
  Future<UserCredential?> signInWithGoogle() async {
    if (kIsWeb) {
      debugPrint('Logando na Web!');
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      // Faça o login com o provedor Google e retorne a UserCredential
      return await FirebaseAuth.instance.signInWithPopup(googleProvider);

      // Ou use signInWithRedirect
      // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
    } else {
      debugPrint('Logando no Android!');
      // Obtém os detalhes de autenticação da solicitação
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Cria uma nova credencial
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Uma vez conectado, retorne o UserCredential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Uma vez conectado, retorne o UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    if (kIsWeb) {
      // Cria um novo provedor
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
      });

      // Uma vez conectado, retorne o UserCredential
      return await FirebaseAuth.instance.signInWithPopup(facebookProvider);

      // Ou use signInWithRedirect
      // retorna await FirebaseAuth.instance.signInWithRedirect(facebookProvider);
    } else {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(
        loginResult.accessToken!.token,
      );

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }
  }

  @override
  Widget build(BuildContext context) {
    void pageDashBoard() {
      Navigator.of(context).pushReplacementNamed(AppRoutes.dashBoard);
    }

    return SizedBox(
      child: Column(
        children: [
          const Text('Logue também com:'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  signInWithGoogle().then((userCredential) {
                    // O usuário foi logado com sucesso, faça algo aqui
                    debugPrint(
                        'Usuário logado com o google: ${userCredential?.user}');
                    pageDashBoard();
                    showSuccess(
                        'Parabén ${userCredential?.user?.displayName} você logou com sucesso!');
                  }).catchError((error) {
                    // Ocorreu um erro durante o login com o Google, trate o erro aqui
                    debugPrint('Erro de login com o Google: $error');
                  });
                },
                splashColor: Colors.black,
                child: SizedBox(
                  width: 120,
                  height: 50,
                  child: Card(
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.lightbulb_outlined,
                          color: Colors.green,
                        ),
                        Text(' Google')
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('ou'),
              InkWell(
                onTap: () {
                  signInWithFacebook().then((userCredential) {
                    debugPrint(
                        'Usuário logado com o Facebook: ${userCredential?.user}');
                    pageDashBoard();
                    showSuccess(
                        'Parabén ${userCredential?.user?.displayName} você logou com sucesso!');
                  }).catchError((error) {
                    debugPrint('Erro de login com o Facebook: $error');
                  });
                },
                splashColor: Colors.black,
                child: SizedBox(
                  width: 120,
                  height: 50,
                  child: Card(
                    elevation: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.facebook_rounded,
                          color: Colors.green,
                        ),
                        Text(' Facebook')
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
