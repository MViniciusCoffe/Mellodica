import 'package:flutter/material.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void submit(BuildContext context) {
    debugPrint('Email: ${emailController.text}, Password: ${passwordController.text}');
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}