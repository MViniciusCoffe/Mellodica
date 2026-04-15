import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}