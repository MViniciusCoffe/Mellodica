import 'package:flutter/material.dart';
import 'views/welcome_view.dart';

void main() {
  runApp(const MellodicaApp());
}

class MellodicaApp extends StatelessWidget {
  const MellodicaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mellodica',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: WelcomeView(),
    );
  }
}