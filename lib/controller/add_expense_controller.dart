import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackermobileapp/controller/auth_controller.dart';
import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:expensetrackermobileapp/utils/show_dialog_progress_bar.dart';
import 'package:flutter/material.dart';

class AddExpenseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addExpenseDetails(
      String title,
      String amount,
      String category,
      String date,
      BuildContext context,
      TextEditingController titleController,
      TextEditingController amountController) async {
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
          titleController.clear();
          amountController.clear();
        },
      );
    } catch (e) {
      if (context.mounted) {
        DialogProgressBar.hideLoadingDialog(context);
      }
    }
  }

  deleteExpense(String id, BuildContext context) {
    firestore.collection(auth.currentUser!.uid).doc(id).delete().then((value) {
      Navigator.of(context).pop();
      ReusableSnackBar.showSnackBar(context, "Expenses Deleted");
    }).onError((error, stackTrace) {
      ReusableSnackBar.showSnackBar(context, "Failed to delete expense");
    });
  }

  updateExpense(
    String title,
    String amount,
    String category,
    String date,
    String id,
    BuildContext context,
  ) {
    firestore.collection(auth.currentUser!.uid).doc(id).update(
      {
        "expenseTitle": title,
        "expenseAmount": amount,
        "expenseCategory": category,
        "expenseDate": date,
      },
    ).then((value) {
      ReusableSnackBar.showSnackBar(context, "Expense Edited");
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      ReusableSnackBar.showSnackBar(context, "Error updating expense");
    });
  }
}
