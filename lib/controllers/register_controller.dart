import 'package:flutter/material.dart';
import 'fields_validators.dart';
import '../models/instrument.dart';
import '../views/login_view.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Cadastro realizado com sucesso! Instrumento: ${instrument?.label}",
          ),
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
    instrument = null;
  }

  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}
