import 'dart:convert';
import 'package:http/http.dart' as http;

class SongRemoteSource {
  static const _baseUrl = 'https://saavn.sumit.co';

  Future<List<dynamic>> searchSongs(
    String query, {
    int limit = 10,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/api/search/songs?query=$query&limit=$limit',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch songs');
    }

    final decoded = jsonDecode(response.body);
    return decoded['data']['results'];
  }
}