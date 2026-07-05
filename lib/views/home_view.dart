import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = InMemoryUserService().currentUser;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.white70,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.deepPurple),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileView()),
              );
            },
          ),
        ],
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
