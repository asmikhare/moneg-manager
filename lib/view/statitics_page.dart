import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackermobileapp/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
// import 'package:pie_chart/pie_chart.dart';

class StatiticsPage extends StatefulWidget {
  const StatiticsPage({super.key});

  @override
  State<StatiticsPage> createState() => _StatiticsPageState();
}

class _StatiticsPageState extends State<StatiticsPage> {
  final expenseDataStream =
      FirebaseFirestore.instance.collection(auth.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Expense Statistics"),
      ),
      body: StreamBuilder(
          stream: expenseDataStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("An error occured"),
              );
            } else {
              var expenses = snapshot.data!.docs;
              Map<String, double> titleTotals = {};
              for (var expense in expenses) {
                var data = expense.data();
                var title = data['expenseCategory'];
                var amount = data['expenseAmount'];

                if (titleTotals[title] != null) {
                  titleTotals[title] =
                      (titleTotals[title] ?? 0) + double.parse(amount);
                } else {
                  titleTotals[title] = double.parse(amount);
                }
              }
              return PieChart(dataMap: titleTotals);
            }
          }),
    );
  }
}
