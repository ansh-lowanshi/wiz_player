import 'dart:convert';
import 'package:http/http.dart' as http;

class SongRemoteSource {
  static const _baseUrl = 'https://saavn.sumit.co';

  Future<List<dynamic>> searchSongs(String query, {int? limit}) async {
    final finalLimit = limit ?? 10;
    final uri = Uri.parse(
      '$_baseUrl/api/search/songs?query=$query&limit=$finalLimit',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch songs');
    }

    final decoded = jsonDecode(response.body);
    return decoded['data']['results'];
  }

  Future<Map<String, dynamic>> searchAll(String query) async {
    final uri = Uri.parse(
      '$_baseUrl/api/search?query=$query',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to search");
    }
  }
}
