import 'package:flutter/material.dart';

class ToastManager {
  static sewaSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 700),
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
