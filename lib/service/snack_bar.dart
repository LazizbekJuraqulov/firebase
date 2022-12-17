import 'package:flutter/material.dart';

class SnackBarService {
  static const errorColor = Colors.red;
  static const okClor = Colors.green;
  static Future<void> showSnackBar(
      BuildContext context, String message, bool error) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: error ? errorColor : okClor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
