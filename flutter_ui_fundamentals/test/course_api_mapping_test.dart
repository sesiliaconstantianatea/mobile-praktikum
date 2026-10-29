import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_ui_fundamentals/services/course_api_service.dart';

void main() {
  test(
    'JSON mapping error ditangani saat key title tidak tersedia',
    () async {
      final client = MockClient((request) async {
        return http.Response(
          '[{"id": 1, "name": "Pemrograman Mobile"}]',
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
    },
  );
}
