
import '../lib/services/course_api_service.dart';

Future<void> main() async {
  final service = CourseApiService(
    'https://jsonplaceholder.typicode.com',
  );

  try {
    final courses = await service.getCourses();

    print('Jumlah data diterima: ${courses.length}');
    print('Judul data pertama: ${courses.first.title}');
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}
