import 'package:flutter/material.dart';
import 'package:mellodica/models/instrument.dart';
import '../controllers/onboarding_controller.dart';
import '../models/level.dart';

class OnboardingView extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final Instrument instrument;

  const OnboardingView({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.instrument,
  });

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _controller = OnboardingController();
  @override
  Widget build(BuildContext context) {
    final levelData = {
      Level.beginner: (icon: Icons.eco, color: Colors.green),
      Level.intermediate: (icon: Icons.star, color: Colors.amber),
      Level.advanced: (icon: Icons.flash_on, color: Colors.red),
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboarding"),
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bem-vindo(a) ao Mellodica!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Text(
                "Para começar, selecione seu nível de habilidade:",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ...Level.values.map((level) {
                final data = levelData[level]!;
                return GestureDetector(
                  onTap: () {
                    setState(() => _controller.selectedLevel = level);
                  },
                  child: Card(
                    color: _controller.selectedLevel == level
                        ? data.color.withValues(alpha: 0.3)
                        : Colors.white,
                    child: ListTile(
                      leading: Icon(data.icon, color: data.color),
                      title: Text(level.label),
                    ),
                  ),
                );
              }),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _controller.submit(
                      context,
                      name: widget.name,
                      email: widget.email,
                      password: widget.password,
                      instrument: widget.instrument,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Finalizar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
