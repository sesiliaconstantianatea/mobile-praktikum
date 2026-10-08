import 'package:flutter/material.dart';

const String studentName = 'Sesilia Constantiana Tea';

const String studentId = '2415051112';

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(

        appBar: AppBar(

          title: const Text('Flutter UI Fundamentals'),

        ),

        body: Center(

          child: Text('$studentId - $studentName'),

        ),

      ),

    );

  }

} ini isi main dart