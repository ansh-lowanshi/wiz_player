import 'package:wiz_player/domain/entities/playlist_detail_entity.dart';
import 'package:wiz_player/domain/entities/playlist_entity.dart';

abstract class PlaylistRepo {
  Future<List<PlayListEntity>> searchPlaylist(String query, {int? limit});
  Future<PlaylistDetailEntity> searchPlaylistById(String query, String limit);
}
