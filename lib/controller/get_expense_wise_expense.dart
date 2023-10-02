// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:expensetrackermobileapp/controller/auth_controller.dart';
// import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
// import 'package:flutter/material.dart';

// Future<Map<String, double>> getDataFromFirebase() async {
//   Map<String, double> categorySums = {};

//   try {
//     CollectionReference collectionRef =
//         FirebaseFirestore.instance.collection(auth.currentUser!.uid);
//     QuerySnapshot querySnapshot = await collectionRef.get();
//     for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
//       if (documentSnapshot.exists) {
//         Map<String, dynamic> data =
//             documentSnapshot.data() as Map<String, dynamic>;
//         String expenseCategory = data['expenseCategory'];
//         double expenseAmount = double.parse(data['expenseAmount']);
//         if (categorySums.containsKey(expenseCategory)) {
//           categorySums[expenseCategory] =
//               (categorySums[expenseCategory] ?? 0) + expenseAmount;
//         } else {
//           categorySums[expenseCategory] = expenseAmount;
//         }
//       }
//     }
//   } catch (e) {}
//   return categorySums;
// }
