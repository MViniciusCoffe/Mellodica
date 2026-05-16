import 'package:flutter/material.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email é obrigatório";
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(value) ? null : "E-mail Inválido";
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Senha é obrigatória";
    if (value.length < 6) return "Senha deve ter pelo menos 6 caracteres";
    return null;
  }

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
  }
}
