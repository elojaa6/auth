// ignore_for_file: use_build_context_synchronously

import 'package:auth/components/my_button.dart';
import 'package:auth/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  //* resert password
  void passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showErrorMessage('Password reset link sent! Check your email');

    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.message.toString());
    }
  }

  //* error message to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade500,
          title: Center(
              child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Enter Your Email and we will send you a passsword reset link!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          //* Email textfield
          MyTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
          ),

          const SizedBox(
            height: 25,
          ),

          //* send email
          MyButton(text: 'Send Email', onTap: () => passwordReset()),
        ],
      ),
    );
  }
}
