import 'package:flutter/material.dart';

class SnackBarMessage {
  static successMessage(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: const EdgeInsets.all(20.0),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.green.shade700,
        content: Text(message)));
  }

  static errorMessage(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        margin: const EdgeInsets.all(20.0),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.red.shade700,
        content: Text(message)));
  }
}
