import 'package:expensetrackermobileapp/controller/auth_controller.dart';
import 'package:expensetrackermobileapp/validations/email_validation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController resetEmailController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    resetEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: globalKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.5,
                  child: Lottie.asset(
                      "asset/animation/ResetPasswordAnimation.json"),
                ),
                TextFormField(
                  validator: (value) {
                    final message = EmailValidation.validateEmail(value!);
                    return message;
                  },
                  controller: resetEmailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  height: size.height * 0.06,
                  minWidth: size.width,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      AuthController.sendResetLink(
                          resetEmailController.text, context);
                    }
                  },
                  child: const Text(
                    "Send reset link",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
