import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/course_provider.dart';
import '../widgets/course_card.dart';

class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(
        child: Text('Error: ${provider.error}', style: const TextStyle(color: Colors.red)),
      );
    }

    return ListView.builder(
      itemCount: provider.courses.length,
      itemBuilder: (context, index) {
        return CourseCard(course: provider.courses[index]);
      },
    );
  }
}