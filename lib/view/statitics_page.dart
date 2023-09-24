import 'package:flutter/material.dart';

class StatiticsPage extends StatefulWidget {
  const StatiticsPage({super.key});

  @override
  State<StatiticsPage> createState() => _StatiticsPageState();
}

class _StatiticsPageState extends State<StatiticsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Stat Page"),
      ),
    );
  }
}
