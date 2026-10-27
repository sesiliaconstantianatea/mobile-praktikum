
import '../lib/services/course_api_service.dart';

Future<void> main() async {
  final service = CourseApiService(
    'https://jsonplaceholder.typicode.com',
  );

  try {
    final posts = await service.getCourses();

    print('Jumlah data diterima: ${posts.length}');
    print('Judul data pertama: ${posts.first['title']}');
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}
