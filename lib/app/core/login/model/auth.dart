import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:iasd_myadmin/app/exceptions/auth_exception.dart';
class Auth with ChangeNotifier {
  
  final String apikey = const String.fromEnvironment('APIKEY');

  Future<void> authenticate(String email, String senha, String urlFragment) async {
    final url = 'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=$apikey';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': senha,
          'returnSecureToken': true
        }
      ),
    );
    final body = jsonDecode(response.body);
    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    }
    if (kDebugMode) {
      print(body['error']);
    }
  }

  Future<void> singUp(String email, String senha) async {
    return authenticate(email, senha, 'signUp');
  } 
  Future<void> login(String email, String senha) async {
   return authenticate(email, senha, 'signInWithPassword');
  } 

}