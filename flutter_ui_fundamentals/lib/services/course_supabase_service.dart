
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<List<Course>> getCourses() async {
    final data = await _supabase
        .from('courses')
        .select('id, code, title, credits, status')
        .order('id');

    return data.map((item) {
      return Course.fromJson(item);
    }).toList();
  }

  @override
  Future<Course> createCourse(Course course) {
    throw UnimplementedError('Belum diterapkan');
  }

  @override
  Future<void> updateCourse(int id, Course course) {
    throw UnimplementedError('Belum diterapkan');
  }

  @override
  Future<void> deleteCourse(int id) {
    throw UnimplementedError('Belum diterapkan');
  }
}
