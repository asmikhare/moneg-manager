import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatiticsPage extends StatefulWidget {
  const StatiticsPage({super.key});

  @override
  State<StatiticsPage> createState() => _StatiticsPageState();
}

class _StatiticsPageState extends State<StatiticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Statistics"),
      ),
      body: const PieChart(
        dataMap: {
          "Education": 210,
          "Food": 203,
          "Insurance": 1000,
          "Entertainment": 400,
          "Other": 200,
        },
      ),
    );
  }
}
