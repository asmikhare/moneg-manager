import 'package:expensetrackermobileapp/provider/change_index_provider.dart';
import 'package:expensetrackermobileapp/provider/change_selected_category.dart';
import 'package:expensetrackermobileapp/provider/date_selector_provider.dart';
import 'package:expensetrackermobileapp/provider/profile_image_provider.dart';
import 'package:expensetrackermobileapp/provider/show_hide_password.dart';
import 'package:expensetrackermobileapp/view/forgot_password_page.dart';
import 'package:expensetrackermobileapp/view/home_page.dart';
import 'package:expensetrackermobileapp/view/login_page.dart';
import 'package:expensetrackermobileapp/view/signup_page.dart';
import 'package:expensetrackermobileapp/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChangeIndexProvider()),
        ChangeNotifierProvider(create: (context) => ProfileImageProvider()),
        ChangeNotifierProvider(create: (context) => ChangeSelectedCategory()),
        ChangeNotifierProvider(create: (context) => DateSelectorProvider()),
        ChangeNotifierProvider(create: (context) => ShowHidePassword()),
      ],
      child: MaterialApp(
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
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            centerTitle: true,
          ),
          brightness: Brightness.light,
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}
