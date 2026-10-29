import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_ui_fundamentals/services/course_api_service.dart';

void main() {
  test('HTTP 403 ditangani sebagai akses ditolak', () async {
    final client = MockClient((request) async {
      return http.Response(
        '{"message":"Permission denied"}',
        403,
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
                error.toString().contains('403') &&
                error.toString().contains('akses ditolak'),
          ),
        ),
      );
    } finally {
      service.close();
    }
  });
}
