import 'package:flutter/material.dart';
import 'fields_validators.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  String? validateEmail(String? value) =>
      FieldsValidators().validateEmail(value);
  String? validatePassword(String? value) =>
      FieldsValidators().validatePassword(value);
  String? validateName(String? value) =>
      FieldsValidators.required(value, "Nome");

  void submit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Cadastro realizado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );

      formKey.currentState?.reset();
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
