import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_provider.dart';
import 'models/course.dart';

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

  // Data JSON sementara (Tahap 9 akan dipindah ke service)
  static const List<Map<String, dynamic>> rawCourses = [
    {'code': 'IF101', 'title': 'Pemrograman Mobile', 'credits': 3, 'status': 'Aktif'},
    {'code': 'IF102', 'title': 'Basis Data', 'credits': 3, 'status': 'Aktif'},
    {'code': 'IF103', 'title': 'Struktur Data', 'credits': 4, 'status': 'Selesai'},
  ];

  @override
  Widget build(BuildContext context) {
    // Map diubah menjadi object Course lewat Course.fromJson
    final List<Course> courses =
        rawCourses.map((json) => Course.fromJson(json)).toList();

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
          const FavoriteCounter(),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return ListTile(
                  title: Text(course.title),
                  subtitle: Text(
                    '${course.code} • ${course.credits} SKS • ${course.status}',
                  ),
                  trailing: Consumer<CourseProvider>(
                    builder: (context, provider, child) {
                      final isFav = provider.favorites.contains(course.code);
                      return IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : null,
                        ),
                        onPressed: () => context
                            .read<CourseProvider>()
                            .toggleFavorite(course.code),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteCounter extends StatelessWidget {
  const FavoriteCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final total = context.watch<CourseProvider>().favorites.length;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text('Jumlah favorite: $total'),
    );
  }
}