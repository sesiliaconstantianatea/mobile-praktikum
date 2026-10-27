
import '../lib/services/post_api_service.dart';

Future<void> main() async {
  try {
    final post = await PostApiService().fetchPost();

    print('GET berhasil!');
    print('ID: ${post['id']}');
    print('Judul: ${post['title']}');
    print('Isi: ${post['body']}');
  } catch (e) {
    print('Terjadi kesalahan: $e');
  }
}
