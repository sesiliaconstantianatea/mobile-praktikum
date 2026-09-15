import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Pertama',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aplikasi Pertama'),
        ),
        body: const Center(
          child: Text(
            'Aplikasi Pertama — Sesilia Constantiana Tea',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}