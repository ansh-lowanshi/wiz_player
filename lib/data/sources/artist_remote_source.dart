import 'dart:convert';
import 'package:http/http.dart' as http;

class ArtistRemoteSource {
  static const _baseUrl = 'https://saavn.sumit.co';

  Future<List<dynamic>> searchArtists(String query, {int? limit}) async {
    final uri = Uri.parse(
      '$_baseUrl/api/search/artists?query=$query&limit=$limit',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch artists');
    }

    final decoded = jsonDecode(response.body);
    return decoded['data']['results'];
  }
}
