import 'package:flutter/material.dart';

class LogoutDialogBox {
  static askForLogout(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Do you really want to logout?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Yes"),
              ),
            ],
          );
        });
  }
}
