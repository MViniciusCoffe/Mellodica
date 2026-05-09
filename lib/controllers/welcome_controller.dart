import 'package:flutter/material.dart';
import '../views/register_view.dart';

class WelcomeController {

  void goToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterView()),
    );
  }
}