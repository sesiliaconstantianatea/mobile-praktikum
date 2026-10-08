import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'course_provider.dart';
import 'models/course.dart';
import 'services/course_service.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CourseService _service = CourseService();
  List<Course> _courses = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final result = await _service.loadCourses();
    // Uji service: lihat hasilnya di terminal
    debugPrint('Service memuat ${result.length} course: '
        '${result.map((c) => c.code).toList()}');
    if (!mounted) return;
    setState(() => _courses = result);
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
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