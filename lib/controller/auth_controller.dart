import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:expensetrackermobileapp/utils/show_dialog_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
late String message;

class AuthController extends GetxController {
  static loginUser(String email, String password, BuildContext context) async {
    DialogProgressBar.showDialogProgressBar(context);
    auth.signInWithEmailAndPassword(email: email, password: password).then(
      (value) {
        DialogProgressBar.hideLoadingDialog(context);
        Navigator.pushReplacementNamed(context, "/myhomepage");
      },
    ).onError(
      (error, stackTrace) {
        DialogProgressBar.hideLoadingDialog(context);
        if (error is FirebaseAuthException) {
          ReusableSnackBar.showSnackBar(context, error.message.toString());
        } else {
          ReusableSnackBar.showSnackBar(context, error.toString());
        }
      },
    );
  }

  static createUser(String email, String password, BuildContext context) async {
    DialogProgressBar.showDialogProgressBar(context);
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        DialogProgressBar.hideLoadingDialog(context);
        ReusableSnackBar.showSnackBar(context, "Account created");
        Navigator.pushReplacementNamed(context, "/myhomepage");
      },
    ).onError((error, stackTrace) {
      if (error is FirebaseAuthException) {
        ReusableSnackBar.showSnackBar(context, error.message.toString());
      } else {
        ReusableSnackBar.showSnackBar(context, error.toString());
      }
    });
  }

  static sendResetLink(String email, BuildContext context) async {
    await auth.sendPasswordResetEmail(email: email).then((value) {
      ReusableSnackBar.showSnackBar(
          context, "Reset link sent sucessfully,check email");
    }).onError(
      (error, stackTrace) {
        ReusableSnackBar.showSnackBar(
            context, "Failed to send reset link mail");
      },
    );
  }
}
