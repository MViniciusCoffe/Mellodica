import "package:flutter/material.dart";
import '../controllers/profile_controller.dart';
import '../services/user_service.dart';
import '../models/level.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    final user = InMemoryUserService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepPurple,
                child: const Icon(Icons.person, size: 50, color: Colors.white),
              ),

              const SizedBox(height: 16),

              Text(
                user?.name ?? "Usuário",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                user?.email ?? "",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),

              const SizedBox(height: 24),

              Card(
                child: ListTile(
                  leading: const Icon(Icons.music_note),
                  title: Text(user?.instrument.label ?? "Sem instrumento"),
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Estatísticas",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Text("⭐ XP Total: "),
                  Text("0", style: TextStyle(color: Colors.deepPurple)),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Text("📊 Nível: "),
                  Text(
                    user?.level.label ?? "Sem nível",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Text("✅ Lições: "),
                  Text("0", style: TextStyle(color: Colors.deepPurple)),
                ],
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _controller.logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Sair da conta",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
