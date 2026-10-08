import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final favs = provider.favoriteCourses;

    if (favs.isEmpty) {
      return const Center(
        child: Text('Belum ada course yang difavoritkan.', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: favs.length,
      itemBuilder: (context, index) {
        return CourseCard(course: favs[index]);
      },
    );
  }
}