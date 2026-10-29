
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
  Future<Course> createCourse(Course course) async {
    final row = await _supabase
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();

    return Course.fromJson(row);
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    await _supabase
        .from('courses')
        .update(course.toJson())
        .eq('id', id);
  }

  @override
  Future<void> deleteCourse(int id) async {
    await _supabase
        .from('courses')
        .delete()
        .eq('id', id);
  }
}
