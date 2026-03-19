import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wiz_player/data/model/playlist_detail_model.dart';

class PlaylistRemoteSource {
  static const _baseUrl = 'https://saavn.sumit.co';

  Future<List<dynamic>> searchPlaylist(String query, {int? limit}) async {
    final finalLimit = 10;
    final uri = Uri.parse(
      '$_baseUrl/api/search/playlists?query=$query&limit=$finalLimit',
    );
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch albums');
    }

    final decoded = jsonDecode(response.body);
    return decoded['data']['results'];
  }

  Future<PlaylistDetailModel> searchPlaylistById(
    String id,
    String limit,
  ) async {
    final url = Uri.parse('$_baseUrl/api/playlists?id=$id&limit=$limit');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch the Album');
    }

    final decoded = jsonDecode(response.body);

    return PlaylistDetailModel.fromJson(decoded);
  }
}
