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

  Future<Map<String, dynamic>> searchSongById(String id) async {
    final uri = Uri.parse('$_baseUrl/api/songs/$id');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch songs');
    }

    final decoded = jsonDecode(response.body);

    return decoded['data'][0];
  }

  Future<List<dynamic>> songSuggestions(String id) async {
    final uri = Uri.parse('$_baseUrl/api/songs/$id/suggestions');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch song suggestions');
    }

    final decoded = jsonDecode(response.body);

    return decoded['data'];
  }
}
