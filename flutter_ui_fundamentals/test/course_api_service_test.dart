import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_ui_fundamentals/services/course_api_service.dart';

void main() {
  // KASUS A: HTTP 404 - Endpoint tidak ditemukan
  test('HTTP 404 ditangani dengan pesan error yang jelas', () async {
    final client = MockClient((request) async {
      return http.Response('Not Found', 404);
    });

    final service = CourseApiService(
      'https://example.com/wrong-endpoint',
      client: client,
    );

    try {
      await expectLater(
        service.getCourses(),
        throwsA(
          predicate(
            (error) =>
                error.toString().contains('404') &&
                error.toString().contains('endpoint'),
          ),
        ),
      );
    } finally {
      service.close();
    }
  });

  // KASUS B: No Internet - Koneksi gagal
  test('Kegagalan koneksi ditangani tanpa crash', () async {
    final client = MockClient((request) async {
      throw http.ClientException('No Internet connection');
    });

    final service = CourseApiService(
      'https://example.com/posts',
      client: client,
    );

    try {
      await expectLater(
        service.getCourses(),
        throwsA(
          predicate(
            (error) =>
                error.toString().contains('koneksi internet'),
          ),
        ),
      );
    } finally {
      service.close();
    }
  });
}
