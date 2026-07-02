import 'package:flutter/material.dart';
import 'fields_validators.dart';
import '../models/instrument.dart';
import '../views/login_view.dart';
import '../views/home_view.dart';
import '../services/user_service.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  Instrument? instrument;

  String? validateEmail(String? value) =>
      FieldsValidators().validateEmail(value);
  String? validatePassword(String? value) =>
      FieldsValidators().validatePassword(value);
  String? validateName(String? value) =>
      FieldsValidators.required(value, "Nome");
  String? validateInstrument(Instrument? value) {
    if (value == null) return "Selecione um instrumento";
    return null;
  }

  void submit(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      final result = InMemoryUserService().register(
        nameController.text,
        emailController.text,
        passwordController.text,
        instrument!,
      );

      if (!result.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.error ?? "Erro ao cadastrar usuário"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Cadastro realizado com sucesso! Instrumento: ${instrument?.label}",
          ),
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
    nameController.dispose();
    instrument = null;
  }

  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}
