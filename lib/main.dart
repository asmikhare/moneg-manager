import 'package:expensetrackermobileapp/view/login_page.dart';
import 'package:expensetrackermobileapp/view/signup_page.dart';
import 'package:expensetrackermobileapp/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      routes: {
        "/splashscreen": (context) => const SplashScreen(),
        "/loginpage": (context) => const LoginPage(),
        "/signuppage": (context) => const SignupPage(),
      },
      initialRoute: "/splashscreen",
      theme: ThemeData(brightness: Brightness.light),
    );
  }
}
