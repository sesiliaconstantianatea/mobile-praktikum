
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/course.dart';

class CourseApiService {
  final String baseUrl;

  CourseApiService(this.baseUrl);

  Future<List<Course>> getCourses() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal mengambil data: ${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body) as List<dynamic>;

    return data.map((item) {
      final post = item as Map<String, dynamic>;

      return Course(
        id: post['id'] as int,
        code: 'API${post['id']}',
        title: post['title'] as String,
        credits: 3,
        status: 'Aktif',
      );
    }).toList();
  }
}
