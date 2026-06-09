import 'package:flutter/material.dart';
import 'fields_validators.dart';
import '../views/home_view.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) => FieldsValidators().validateEmail(value);
  String? validatePassword(String? value) => FieldsValidators().validatePassword(value);

  void submit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Login realizado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );

      formKey.currentState?.reset();

      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => HomeView())
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
