
import 'dart:convert';
import 'package:http/http.dart' as http;

class PostApiService {
  static const String _url =
      'https://jsonplaceholder.typicode.com/posts/1';

  Future<Map<String, dynamic>> fetchPost() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Gagal mengambil data. Status: ${response.statusCode}',
      );
    }
  }
}
