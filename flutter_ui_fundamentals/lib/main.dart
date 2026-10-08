import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_provider.dart';

const String studentName = 'SESILIA CONSTANTIANA TEA';
const String studentId = '2415051112';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CourseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Explorer',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Map<String, String>> courses = [
    {'code': 'IF101', 'title': 'Pemrograman Mobile'},
    {'code': 'IF102', 'title': 'Basis Data'},
    {'code': 'IF103', 'title': 'Struktur Data'},
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(24),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text('$studentName - $studentId'),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text('Jumlah favorite: ${provider.favorites.length}'),
          ),
          Expanded(
            child: ListView(
              children: courses.map((c) {
                final isFav = provider.favorites.contains(c['code']);
                return ListTile(
                  title: Text(c['title']!),
                  subtitle: Text(c['code']!),
                  trailing: IconButton(
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                    onPressed: () =>
                        context.read<CourseProvider>().toggleFavorite(c['code']!),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}