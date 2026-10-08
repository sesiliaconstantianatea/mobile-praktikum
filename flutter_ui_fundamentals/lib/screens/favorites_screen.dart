import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final favList = provider.favoriteCourses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Favorit Saya'),
      ),
      body: favList.isEmpty
          ? const Center(
              child: Text(
                'Belum ada mata kuliah favorit.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: favList.length,
              itemBuilder: (context, index) {
                final course = favList[index];
                return CourseCard(
                  course: course,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailScreen(course: course),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}