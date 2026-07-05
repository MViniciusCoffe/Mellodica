import 'package:flutter/material.dart';
import '../views/welcome_view.dart';
import '../services/user_service.dart';

class ProfileController {
  void logout(BuildContext context) {
    InMemoryUserService().logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => WelcomeView()),
      (route) => false,
    );
  }
}
