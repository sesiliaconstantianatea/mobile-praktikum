import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<CourseProvider>().isFavorite(course.code);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed: () {
              context.read<CourseProvider>().toggleFavorite(course.code);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Kode Mata Kuliah: ${course.code}', style: const TextStyle(fontSize: 16)),
            Text('Jumlah SKS: ${course.credits}', style: const TextStyle(fontSize: 16)),
            Text('Status: ${course.status}', style: const TextStyle(fontSize: 16)),
            const Divider(height: 32),
            Row(
              children: [
                const Text('Status Favorit: ', style: TextStyle(fontSize: 16)),
                Chip(
                  avatar: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.red : Colors.grey,
                  ),
                  label: Text(isFav ? 'Favorit Saya' : 'Bukan Favorit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}