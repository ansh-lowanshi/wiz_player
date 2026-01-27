import 'dart:convert';
import 'package:http/http.dart' as http;

class AlbumRemoteSource {
  static const _baseUrl = 'https://saavn.sumit.co';

  Future<List<dynamic>> searchAlbums(
    String query, {
    int limit = 10,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/api/search/albums?query=$query&limit=$limit',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch albums');
    }

    final decoded = jsonDecode(response.body);
    return decoded['data']['results'];
  }
}