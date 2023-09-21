import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 300,
            width: size.width,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              children: [
                ListTile(
                  leading: Text(DateTime.now().day.toString()),
                  trailing: const CircleAvatar(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
