import 'package:flutter/material.dart';
import 'fields_validators.dart';
import '../models/instrument.dart';
import '../views/login_view.dart';
import '../views/onboarding_view.dart';
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
      if (InMemoryUserService().isEmailTaken(emailController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Email já cadastrado"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (instrument == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Selecione um instrumento"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingView(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            instrument: instrument!,
          ),
        ),
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
