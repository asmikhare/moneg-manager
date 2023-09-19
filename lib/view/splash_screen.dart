import 'package:expensetrackermobileapp/constants/text_styles.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: size.height * 0.63,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("asset/images/WallateImage.png"),
              ),
            ),
          ),
          SizedBox(
            height: size.height - size.height * 0.63,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Simple solution for\nyour budget",
                  textAlign: TextAlign.center,
                  style: splashScreenTextStyleMain,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Counter and distribute the income\ncorrectly...",
                  textAlign: TextAlign.center,
                  style: splashScreenTextStyleSubtitle,
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/loginpage");
                  },
                  color: Colors.black,
                  minWidth: size.width * 0.45,
                  height: size.height * 0.07,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
