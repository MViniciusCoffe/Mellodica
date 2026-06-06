import 'package:flutter/material.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeController _controller = WelcomeController();

  WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(),
              _buildTitle(),
              _buildSubtitle(),
              _buildSpacer(),
              _buildRegisterButton(context),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12), 
                child: _buildLoginButton(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() =>
    const Icon(Icons.music_note, size: 80, color: Colors.deepPurple);

  Widget _buildTitle() => const Text(
    'Mellodica',
    style: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
  );

  Widget _buildSubtitle() => Text(
    'Aprenda música sem desistir',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
  );

  Widget _buildSpacer() => const SizedBox(height: 40);

  Widget _buildRegisterButton(BuildContext context) => ElevatedButton(
    onPressed: () => _controller.goToRegister(context),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      fixedSize: const Size(175, 50),
    ),
    child: const Text(
      'Registrar',
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
  );

  Widget _buildLoginButton(BuildContext context) => ElevatedButton(
    onPressed: () => _controller.goToLogin(context),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[600],
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      fixedSize: const Size(175, 50),
    ),
    child: const Text(
      'Entrar',
      style: TextStyle(fontSize: 18, color: Colors.white),
    ),
  );
}
