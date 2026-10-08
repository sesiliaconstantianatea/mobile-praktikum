import 'package:flutter/material.dart';

const String studentName = 'SESILIA CONSTANTIANA TEA';
const String studentId = '2415051112';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CourseListPage(),
    );
  }
}

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  final List<Map<String, String>> courses = [
    {
      'code': 'IF101',
      'name': 'Pemrograman Dasar',
      'description': 'Belajar dasar pemrograman.',
    },
    {
      'code': 'IF102',
      'name': 'Pemrograman Mobile',
      'description': 'Belajar pengembangan aplikasi mobile.',
    },
    {
      'code': 'IF103',
      'name': 'Basis Data',
      'description': 'Belajar konsep dan pengelolaan basis data.',
    },
  ];

  final Set<String> favoriteCourses = {};

  void toggleFavorite(String courseCode) {
    setState(() {
      if (favoriteCourses.contains(courseCode)) {
        favoriteCourses.remove(courseCode);
      } else {
        favoriteCourses.add(courseCode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Explorer'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('NIM: $studentId'),
                const SizedBox(height: 8),
                Text(
                  'Favorite: ${favoriteCourses.length} course',
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                final code = course['code']!;
                final name = course['name']!;
                final description = course['description']!;

                final isFavorite = favoriteCourses.contains(code);

                return CourseCard(
                  code: code,
                  name: name,
                  description: description,
                  isFavorite: isFavorite,
                  onFavoriteChanged: () {
                    toggleFavorite(code);
                  },
                  onDetail: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailPage(
                          code: code,
                          name: name,
                          description: description,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final String code;
  final String name;
  final String description;
  final bool isFavorite;
  final VoidCallback onFavoriteChanged;
  final VoidCallback onDetail;

  const CourseCard({
    super.key,
    required this.code,
    required this.name,
    required this.description,
    required this.isFavorite,
    required this.onFavoriteChanged,
    required this.onDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        title: Text(
          '$code - $name',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: IconButton(
          icon: Icon(
            isFavorite
                ? Icons.favorite
                : Icons.favorite_border,
          ),
          onPressed: onFavoriteChanged,
        ),
        onTap: onDetail,
      ),
    );
  }
}

class CourseDetailPage extends StatelessWidget {
  final String code;
  final String name;
  final String description;

  const CourseDetailPage({
    super.key,
    required this.code,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              code,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(description),
          ],
        ),
      ),
    );
  }
}