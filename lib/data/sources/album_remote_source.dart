import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wiz_player/data/model/album_detail_model.dart';

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

  Future<AlbumDetailModel> searchAlbumById(String id) async {
    final uri = Uri.parse('$_baseUrl/api/albums?id=$id');

    final respose = await http.get(uri);

    if (respose.statusCode != 200) {
      throw Exception('Failed to fetch the Album');
    }

    final decoded = jsonDecode(respose.body);

    return AlbumDetailModel.fromJson(decoded);
  }
}
