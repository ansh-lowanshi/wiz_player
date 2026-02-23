import 'package:wiz_player/data/model/song_model.dart';
import 'package:wiz_player/domain/repo/song_repo.dart';

import '../../domain/entities/song_entity.dart';
import '../sources/song_remote_source.dart';

class SongRepositoryImpl implements SongRepository {
  final SongRemoteSource remoteSource;

  SongRepositoryImpl(this.remoteSource);

  @override
  Future<List<SongEntity>> searchSongs(String query, {int? limit}) async {
    final results = await remoteSource.searchSongs(query, limit: limit);

    return SongModel.fromList(results);
  }

  @override
  Future<Map<String, dynamic>> searchAll(String query) async {
    return await remoteSource.searchAll(query);
  }
}
