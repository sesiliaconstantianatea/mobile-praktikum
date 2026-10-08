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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const CourseListPage(),
    );
  }
}

class CourseListPage extends StatelessWidget {
  const CourseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueNotifier menyimpan state sederhana.
    final ValueNotifier<bool> isFavorite =
        ValueNotifier<bool>(false);

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
              ],
            ),
          ),

          const SizedBox(height: 20),

          ValueListenableBuilder<bool>(
            valueListenable: isFavorite,
            builder: (
              context,
              favorite,
              child,
            ) {
              return Column(
                children: [
                  Text(
                    favorite
                        ? 'Course Favorite'
                        : 'Course Belum Favorite',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  IconButton(
                    iconSize: 50,
                    icon: Icon(
                      favorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    onPressed: () {
                      isFavorite.value = !isFavorite.value;
                    },
                  ),

                  Text(
                    favorite
                        ? 'Favorite: Ya'
                        : 'Favorite: Tidak',
                  ),
                ],
              );
            },
          ),

          const Divider(),

          Expanded(
            child: ListView(
              children: const [
                CourseCard(
                  code: 'IF101',
                  name: 'Pemrograman Dasar',
                  description:
                      'Belajar dasar pemrograman.',
                ),
                CourseCard(
                  code: 'IF102',
                  name: 'Pemrograman Mobile',
                  description:
                      'Belajar pengembangan aplikasi mobile.',
                ),
                CourseCard(
                  code: 'IF103',
                  name: 'Basis Data',
                  description:
                      'Belajar konsep dan pengelolaan basis data.',
                ),
              ],
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

  const CourseCard({
    super.key,
    required this.code,
    required this.name,
    required this.description,
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
      ),
    );
  }
}