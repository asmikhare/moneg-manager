import 'package:expensetrackermobileapp/provider/change_index_provider.dart';
import 'package:expensetrackermobileapp/view/add_transaction_page.dart';
import 'package:expensetrackermobileapp/view/landing_home_page.dart';
import 'package:expensetrackermobileapp/view/profile_page.dart';
import 'package:expensetrackermobileapp/view/statitics_page.dart';
import 'package:expensetrackermobileapp/view/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        allowImplicitScrolling: false,
        controller: pageController,
        children: const [
          LandingHomePage(),
          TransactionPage(),
          AddTransactionPage(),
          StatiticsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Consumer<ChangeIndexProvider>(
        builder: (context, value, child) {
          return BottomNavigationBar(
            currentIndex: value.currentIndex,
            onTap: (index) {
              value.changeIndex(index);
              pageController.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Ionicons.home),
                label: "Home",
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.compare_arrows),
                label: "Transaction",
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.add),
                label: "Add Transaction",
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.stats_chart_outline),
                label: "Statistics",
                backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.person),
                label: "Profile",
                backgroundColor: Colors.green,
              ),
            ],
          );
        },
      ),
    );
  }
}
