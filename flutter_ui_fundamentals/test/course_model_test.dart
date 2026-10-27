
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui_fundamentals/models/course.dart';

void main() {
  group('Course Model', () {
    test('fromJson membaca data mata kuliah', () {
      final json = {
        'id': 1,
        'code': 'IF101',
        'title': 'Pemrograman Mobile',
        'credits': 3,
        'status': 'Aktif',
      };

      final course = Course.fromJson(json);

      expect(course.id, 1);
      expect(course.code, 'IF101');
      expect(course.title, 'Pemrograman Mobile');
      expect(course.credits, 3);
      expect(course.status, 'Aktif');
    });

    test('toJson menghasilkan data JSON yang sesuai', () {
      const course = Course(
        id: 1,
        code: 'IF101',
        title: 'Pemrograman Mobile',
        credits: 3,
        status: 'Aktif',
      );

      final json = course.toJson();

      expect(json['code'], 'IF101');
      expect(json['title'], 'Pemrograman Mobile');
      expect(json['credits'], 3);
      expect(json['status'], 'Aktif');
      expect(json.containsKey('id'), isFalse);
    });

    test('status default adalah planned jika tidak tersedia', () {
      final json = {
        'code': 'IF104',
        'title': 'Pemrograman Web',
        'credits': 3,
      };

      final course = Course.fromJson(json);

      expect(course.status, 'planned');
    });
  });
}
