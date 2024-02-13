import 'package:flutter/material.dart';

//* error message to user
void showErrorMessage(String message, BuildContext context) {
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