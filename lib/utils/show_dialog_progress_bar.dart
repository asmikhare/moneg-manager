import 'package:flutter/material.dart';

class DialogProgressBar {
  static showDialogProgressBar(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text("Requesting"),
            ],
          ),
        );
      },
    );
  }

  static hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
