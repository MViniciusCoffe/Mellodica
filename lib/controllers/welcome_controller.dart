import 'package:flutter/material.dart';
import '../views/register_view.dart';
import '../views/login_view.dart';

class WelcomeController {
  void goToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterView()),
    );
  }

  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}
