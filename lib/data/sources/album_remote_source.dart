import 'dart:convert';
import 'package:http/http.dart' as http;

class AlbumRemoteSource {
  static const _baseUrl = 'https://saavn.sumit.co';

  Future<List<dynamic>> searchAlbums(String query, {int? limit}) async {
    final finalLimit = limit ?? 10;
    final uri = Uri.parse(
      '$_baseUrl/api/search/albums?query=$query&limit=$finalLimit',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch albums');
    }

    final decoded = jsonDecode(response.body);
    return decoded['data']['results'];
  }
}
