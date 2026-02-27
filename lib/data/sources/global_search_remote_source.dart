import 'dart:convert';
import 'package:http/http.dart' as http;

class GlobalSearchRemoteSource {
  static const _baseUrl = 'https://saavn.sumit.co';

  Future<Map<String, dynamic>> searchAll(String query, {int? limit}) async {
    final finalLimit = limit ?? 10;
    final uri = Uri.parse(
      '$_baseUrl/api/search?query=$query&limit=$finalLimit',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to search");
    }
  }
}
