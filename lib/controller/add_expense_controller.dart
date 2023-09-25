import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackermobileapp/controller/auth_controller.dart';
import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:expensetrackermobileapp/utils/show_dialog_progress_bar.dart';
import 'package:flutter/material.dart';

class AddExpenseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addExpenseDetails(String title, String amount, String category, String date,
      BuildContext context) async {
    try {
      DialogProgressBar.showDialogProgressBar(context);
      await firestore.collection(auth.currentUser!.uid).doc().set(
        {
          "expenseTitle": title,
          "expenseAmount": amount,
          "expenseCategory": category,
          "expenseDate": date,
        },
      ).then(
        (value) {
          DialogProgressBar.hideLoadingDialog(context);
          ReusableSnackBar.showSnackBar(context, "Expense Added");
        },
      );
    } catch (e) {
      if (context.mounted) {
        DialogProgressBar.hideLoadingDialog(context);
      }
    }
  }
}
