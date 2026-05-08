import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

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
              // _buildStartButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() => const Icon(
      Icons.music_note,
      size: 80,
      color: Colors.deepPurple,
    );

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

  // SizedBox vazio = espaçador invisível
  Widget _buildSpacer() => const SizedBox(height: 40);

  // Widget _buildStartButton(BuildContext context) => ElevatedButton(
  //       // onPressed = gatilho do clique. Chama o controller, não navega direto.
  //       onPressed: () => _controller.goToRegister(context),
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: Colors.deepPurple,
  //         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //       ),
  //       child: const Text(
  //         'Começar',
  //         style: TextStyle(fontSize: 18, color: Colors.white),
  //       ),
  //     );
  // }
}
