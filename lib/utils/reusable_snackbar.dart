import 'package:flutter/material.dart';

class ReusableSnackBar {
  static showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.fixed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
