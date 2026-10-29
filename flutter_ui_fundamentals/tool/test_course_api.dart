import '../lib/services/course_api_service.dart';

Future<void> main() async {
  final service = CourseApiService(
    'https://jsonplaceholder.typicode.com/wrong-endpoint',
  );

  try {
    final courses = await service.getCourses();

    print('Jumlah data diterima: ${courses.length}');
    if (courses.isNotEmpty) {
      print('Judul data pertama: ${courses.first.title}');
    }
  } catch (e) {
    print('Terjadi kesalahan: $e');
  } finally {
    service.close();
  }
}