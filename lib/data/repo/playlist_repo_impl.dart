import 'package:wiz_player/data/model/playlist_detail_model.dart';
import 'package:wiz_player/data/model/playlist_model.dart';
import 'package:wiz_player/data/sources/playlist_remote_source.dart';
import 'package:wiz_player/domain/entities/playlist_detail_entity.dart';
import 'package:wiz_player/domain/entities/playlist_entity.dart';
import 'package:wiz_player/domain/repo/playlist_repo.dart';

class PlaylistRepoImpl implements PlaylistRepo {
  final PlaylistRemoteSource remoteSource;
  PlaylistRepoImpl(this.remoteSource);

  @override
  Future<List<PlayListEntity>> searchPlaylist(
    String query, {
    int? limit,
  }) async {
    final result = await remoteSource.searchPlaylist(query, limit: limit);
    return PlaylistModel.fromList(result);
  }

  @override
  Future<PlaylistDetailEntity> searchPlaylistById(
    String id,
    String limit,
  ) async {
    final result = await remoteSource.searchPlaylistById(id, limit);
    return result;
  }
}
