import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

mixin Messagens<T extends StatefulWidget> on State<T> {
  void showError(String message) {
    _showSnackbar(
      AwesomeSnackbarContent(
        title: 'Erro',
        message: message,
        contentType: ContentType.failure,
      ),
    );
  }

  void showWarning(String message) {
    _showSnackbar(
      AwesomeSnackbarContent(
        title: 'Atenção',
        message: message,
        contentType: ContentType.warning,
      ),
    );
  }

  void showInfo(String message) {
    _showSnackbar(
      AwesomeSnackbarContent(
        title: 'Atenção',
        message: message,
        contentType: ContentType.help,
      ),
    );
  }

  void showSuccess(String message) {
    _showSnackbar(
      AwesomeSnackbarContent(
        title: 'Sucesso',
        message: message,
        contentType: ContentType.success,
      ),
    );
  }

  void _showSnackbar(AwesomeSnackbarContent content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.only(top: 72),
          duration: const Duration(seconds: 10),
          backgroundColor: Colors.transparent,
          content: content),
    );
  }
}
