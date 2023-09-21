import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:expensetrackermobileapp/utils/show_dialog_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
late String message;

class AuthController extends GetxController {
  static loginUser(String email, String password, BuildContext context) async {
    try {
      DialogProgressBar.showDialogProgressBar(context);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          DialogProgressBar.hideLoadingDialog(context);
          message = "Login Sucess";
          ReusableSnackBar.showSnackBar(context, message);
          Navigator.pushReplacementNamed(context, "/myhomepage");
        },
      ).onError(
        (error, stackTrace) {
          DialogProgressBar.hideLoadingDialog(context);
          message = "An error occured";
          ReusableSnackBar.showSnackBar(context, message);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogProgressBar.hideLoadingDialog(context);
      if (e.code == 'user-not-found') {
        message = "User not found";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password for that user";
      }
      ReusableSnackBar.showSnackBar(context, message);
    }
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
      DialogProgressBar.hideLoadingDialog(context);
      if (e.code == 'weak-password') {
        ReusableSnackBar.showSnackBar(context, "Weak password");
      } else if (e.code == 'email-already-in-use') {
        ReusableSnackBar.showSnackBar(context, "Email is already in use");
      }
    } catch (e) {
      ReusableSnackBar.showSnackBar(context, "An unknown error occured");
    }
  }

  static sendResetLink(String email, BuildContext context) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      ReusableSnackBar.showSnackBar(
          context, "Reset link sent sucessfully,check email");
    }).onError(
      (error, stackTrace) {
        debugPrint("$error");
        ReusableSnackBar.showSnackBar(
            context, "Failed to send reset link mail $error");
      },
    );
  }
}
