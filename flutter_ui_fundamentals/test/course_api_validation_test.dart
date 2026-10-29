import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_ui_fundamentals/services/course_api_service.dart';

void main() {
  test('Data JSON tidak valid ditangani dengan pesan error', () async {
    final client = MockClient((request) async {
      return http.Response(
        '[{"id": "bukan-angka", "title": 123}]',
        200,
        headers: {'content-type': 'application/json'},
      );
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
                error.toString().contains('JSON mapping error'),
          ),
        ),
      );
    } finally {
      service.close();
    }
  });

  test('Respons HTTP 422 ditangani sebagai data yang ditolak', () async {
    final client = MockClient((request) async {
      return http.Response(
        '{"message":"Invalid data"}',
        422,
        headers: {'content-type': 'application/json'},
      );
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
                error.toString().contains('422') &&
                error.toString().contains('data ditolak'),
          ),
        ),
      );
    } finally {
      service.close();
    }
  });
}
