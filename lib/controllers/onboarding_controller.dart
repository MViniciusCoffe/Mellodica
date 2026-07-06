import 'package:flutter/material.dart';
import '../models/instrument.dart';
import '../models/level.dart';
import '../services/user_service.dart';
import '../views/home_view.dart';

class OnboardingController {
  Level? selectedLevel;

  void submit(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
    required Instrument instrument,
  }) {
    if (selectedLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Selecione um nível"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final result = InMemoryUserService().register(
      name,
      email,
      password,
      instrument,
      selectedLevel!,
    );

    if (!result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.error ?? "Erro ao realizar cadastro"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  }
}
