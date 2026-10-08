import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback? onTap;

  const CourseCard({
    super.key,
    required this.course,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // context.watch untuk memantau status favorit item ini
    final isFav = context.watch<CourseProvider>().isFavorite(course.code);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        title: Text(
          course.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Kode: ${course.code} | SKS: ${course.credits}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: course.status == 'done'
                    ? Colors.green.shade100
                    : Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                course.status,
                style: TextStyle(
                  color: course.status == 'done'
                      ? Colors.green.shade800
                      : Colors.blue.shade800,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                // context.read untuk memicu action tanpa listen ulang seluruh widget
                context.read<CourseProvider>().toggleFavorite(course.code);
              },
            ),
          ],
        ),
      ),
    );
  }
}