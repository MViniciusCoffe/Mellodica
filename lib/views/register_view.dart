import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastre-se"),
        backgroundColor: Colors.amber,
      ),

      body: Center(
        child: Text("#Issue 1")
      )
    );
  }
}