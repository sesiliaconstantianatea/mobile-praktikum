
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/course.dart';
import 'course_data_source.dart';

class CourseApiService implements CourseDataSource {
  final String baseUrl;
  final http.Client _client;

  CourseApiService(
    this.baseUrl, {
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<http.Response> _request(
    Future<http.Response> Function() action,
  ) async {
    try {
      return await action().timeout(
        const Duration(seconds: 15),
      );
    } on TimeoutException {
      throw Exception(
        'Permintaan timeout. Periksa koneksi internet lalu coba lagi.',
      );
    } on http.ClientException {
      throw Exception(
        'Tidak dapat terhubung ke server. Periksa koneksi internet.',
      );
    } on FormatException {
      throw Exception(
        'Format respons server tidak valid.',
      );
    }
  }

  Exception _httpError(String operation, int statusCode) {
    switch (statusCode) {
      case 400:
        return Exception(
          '$operation: permintaan tidak valid (HTTP 400).',
        );
      case 401:
        return Exception(
          '$operation: autentikasi diperlukan (HTTP 401).',
        );
      case 403:
        return Exception(
          '$operation: akses ditolak (HTTP 403).',
        );
      case 404:
        return Exception(
          '$operation: endpoint tidak ditemukan (HTTP 404). Periksa URL.',
        );
      case 409:
        return Exception(
          '$operation: terjadi konflik data (HTTP 409).',
        );
      case 422:
        return Exception(
          '$operation: data ditolak oleh server (HTTP 422).',
        );
      default:
        return Exception(
          '$operation gagal (HTTP $statusCode).',
        );
    }
  }

  dynamic _decodeJson(String body) {
    try {
      return jsonDecode(body);
    } on FormatException {
      throw Exception(
        'JSON mapping error: respons server bukan JSON yang valid.',
      );
    }
  }

  @override
  Future<List<Course>> getCourses() async {
    final response = await _request(
      () => _client.get(Uri.parse('$baseUrl/posts')),
    );

    if (response.statusCode != 200) {
      throw _httpError('Gagal mengambil course', response.statusCode);
    }

    final data = _decodeJson(response.body);

    if (data is! List) {
      throw Exception(
        'JSON mapping error: respons daftar course harus berupa List.',
      );
    }

    try {
      return data.map<Course>((item) {
        if (item is! Map<String, dynamic>) {
          throw const FormatException(
            'Item course bukan object JSON.',
          );
        }

        final id = item['id'];
        final title = item['title'];

        if (id is! int || title is! String) {
          throw const FormatException(
            'Key id harus int dan title harus String.',
          );
        }

        return Course(
          id: id,
          code: 'API$id',
          title: title,
          credits: 3,
          status: 'active',
        );
      }).toList();
    } on TypeError catch (e) {
      throw Exception(
        'JSON mapping/type error saat membaca course: $e',
      );
    } on FormatException catch (e) {
      throw Exception(
        'JSON mapping error: ${e.message}',
      );
    }
  }

  @override
  Future<Course> createCourse(Course course) async {
    final response = await _request(
      () => _client.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(course.toJson()),
      ),
    );

    if (response.statusCode != 200 &&
        response.statusCode != 201) {
      throw _httpError('Gagal membuat course', response.statusCode);
    }

    final data = _decodeJson(response.body);

    if (data is! Map<String, dynamic>) {
      throw Exception(
        'JSON mapping error: respons course harus berupa object.',
      );
    }

    final id = data['id'];

    if (id != null && id is! int) {
      throw Exception(
        'JSON mapping error: key id harus berupa int.',
      );
    }

    return Course(
      id: id as int?,
      code: course.code,
      title: course.title,
      credits: course.credits,
      status: course.status,
    );
  }

  @override
  Future<void> updateCourse(int id, Course course) async {
    final response = await _request(
      () => _client.put(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(course.toJson()),
      ),
    );

    if (response.statusCode != 200) {
      throw _httpError('Gagal mengubah course', response.statusCode);
    }
  }

  @override
  Future<void> deleteCourse(int id) async {
    final response = await _request(
      () => _client.delete(
        Uri.parse('$baseUrl/posts/$id'),
      ),
    );

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw _httpError('Gagal menghapus course', response.statusCode);
    }
  }

  @visibleForTesting
  void close() {
    _client.close();
  }
}
