import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wiz_player/data/model/album_detail_model.dart';
import 'package:wiz_player/data/model/artist_detail_model.dart';

class ArtistRemoteSource {
  static const _baseUrl = 'https://saavn.sumit.co';

  Future<List<dynamic>> searchArtists(String query, {int? limit}) async {
    final finalLimit = limit ?? 10;
    final uri = Uri.parse(
      '$_baseUrl/api/search/artists?query=$query&limit=$finalLimit',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch artists');
    }

    final decoded = jsonDecode(response.body);
    return decoded['data']['results'];
  }

  Future<ArtistDetailModel>searchArtistById(String id) async{

    final uri = Uri.parse('$_baseUrl/api/artists/$id');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch the Artist Detail');
    }

    final decoded = jsonDecode(response.body);

    return ArtistDetailModel.fromJson(decoded);

  }
}
