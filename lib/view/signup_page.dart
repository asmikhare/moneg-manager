import 'package:expensetrackermobileapp/controller/auth_controller.dart';
import 'package:expensetrackermobileapp/utils/reusable_snackbar.dart';
import 'package:expensetrackermobileapp/validations/email_validation.dart';
import 'package:expensetrackermobileapp/validations/password_validation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.45,
            width: size.width,
            child: Lottie.asset("asset/animation/SignupAnimation.json"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: globalKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      final message = EmailValidation.validateEmail(value!);
                      return message;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      labelText: "Enter your email",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      final message = PasswordValidation.isStrongPass(value!);
                      return message;
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "Define your password",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.visibility),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      final message = PasswordValidation.isStrongPass(value!);
                      return message;
                    },
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.visibility),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                  MaterialButton(
                    elevation: 0,
                    color: Colors.green,
                    height: size.height * 0.06,
                    minWidth: size.width,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      if (globalKey.currentState!.validate() &&
                          passwordController.text
                                  .compareTo(confirmPasswordController.text) ==
                              0) {
                        AuthController.createUser(emailController.text.trim(),
                            passwordController.text, context);
                      } else {
                        ReusableSnackBar.showSnackBar(
                            context, "Both password must match");
                      }
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
