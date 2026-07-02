import 'package:flutter/material.dart';
import '../services/user_service.dart';

final user = InMemoryUserService().currentUser;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.white70,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          "Seja bem vindo, ${user?.name ?? "Usuário"}! Seu instrumento é: ${user?.instrument.label}",
          style: TextStyle(fontSize: 24, color: Colors.deepPurple),
        ),
      ),
    );
  }
}
