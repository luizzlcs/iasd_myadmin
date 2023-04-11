import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
class Auth with ChangeNotifier {
  
  static const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA4zqWL3iLIaHSKe8x2njAQJ5AOCh00Rxo';

  Future<void> singUp(String email, String senha) async {
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
    print(jsonDecode(response.body));
  } 

}