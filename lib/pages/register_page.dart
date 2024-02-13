// ignore_for_file: use_build_context_synchronously

import 'package:auth/components/my_button.dart';
import 'package:auth/components/my_textfield.dart';
import 'package:auth/components/square_tile.dart';
import 'package:auth/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //* text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //*sign user in method
  void signUserUp() async {
    //* show login circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //* try creating the user
    try {
      //* check if password is confirmated
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {

        //* show error message, passwords don't match
        showErrorMessage('Password don\'t match!');
      Navigator.pop(context);

      }

      //* pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //* pop the loading circle
      Navigator.pop(context);
      //* show error message

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
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 25),

              //* logo
              const Icon(
                Icons.lock,
                size: 50,
              ),

              const SizedBox(
                height: 25,
              ),

              //* Let\'s create an account for you!
              Text(
                'Let\'s create an account for you!',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
              ),
              const SizedBox(height: 25),

              //* Email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 25),

              //* Password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              //* Confirm Password textfield
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              //* forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey.shade600),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //* sign in button
              MyButton(text: 'Sign Up', onTap: () => signUserUp()),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              //* google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'images/google.png'),

                  const SizedBox(width: 10),

                  //* apple button
                  SquareTile(onTap: () {}, imagePath: 'images/apple.png'),
                ],
              ),

              const SizedBox(height: 50),

              //* not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login now',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
