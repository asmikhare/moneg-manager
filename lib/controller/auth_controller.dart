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
          if (error.code == "user-not-found") {
            ReusableSnackBar.showSnackBar(context, "User not found");
          } else if (error.code == "wrong-password") {
            ReusableSnackBar.showSnackBar(
                context, "Wrong password for that account");
          } else if (error.code == "network-request-failed") {
            ReusableSnackBar.showSnackBar(context,
                "Network request time out,check your internet connectivity");
          } else {
            ReusableSnackBar.showSnackBar(context, error.code.toString());
          }
        }
      },
    );
  }

  static createUser(String email, String password, BuildContext context) async {
    try {
      DialogProgressBar.showDialogProgressBar(context);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          DialogProgressBar.hideLoadingDialog(context);
          ReusableSnackBar.showSnackBar(context, "Account created");
          Navigator.pushReplacementNamed(context, "/myhomepage");
        },
      );
    } on FirebaseAuthException catch (e) {
      if (context.mounted) DialogProgressBar.hideLoadingDialog(context);
      if (e.code == 'weak-password') {
        if (context.mounted) {
          ReusableSnackBar.showSnackBar(context, "Weak password");
        }
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          ReusableSnackBar.showSnackBar(context, "Email is already in use");
        }
      }
    } catch (e) {
      if (context.mounted) {
        ReusableSnackBar.showSnackBar(context, "An unknown error occured");
      }
    }
  }

  static sendResetLink(String email, BuildContext context) {
    auth.sendPasswordResetEmail(email: email).then((value) {
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
