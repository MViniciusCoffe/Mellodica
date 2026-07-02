import 'package:flutter/material.dart';
import 'fields_validators.dart';
import '../views/home_view.dart';
import '../views/register_view.dart';
import '../services/user_service.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) =>
      FieldsValidators().validateEmail(value);
  String? validatePassword(String? value) =>
      FieldsValidators().validatePassword(value);

  void submit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final result = InMemoryUserService().login(
        emailController.text,
        passwordController.text,
      );

      if (!result.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error ?? "Erro ao realizar login"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Login realizado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );

      formKey.currentState?.reset();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void goToRegister(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterView()),
    );
  }
}
