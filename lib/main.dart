import 'package:expensetrackermobileapp/view/forgot_password_page.dart';
import 'package:expensetrackermobileapp/view/home_page.dart';
import 'package:expensetrackermobileapp/view/login_page.dart';
import 'package:expensetrackermobileapp/view/signup_page.dart';
import 'package:expensetrackermobileapp/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        "/forgotpasswordpage": (context) => const ForgotPasswordScreen(),
        "/myhomepage": (context) => const MyHomePage(),
      },
      initialRoute: "/splashscreen",
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
    );
  }
}
