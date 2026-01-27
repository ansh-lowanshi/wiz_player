import 'package:wiz_player/data/model/album_model.dart';
import 'package:wiz_player/domain/repo/album_repo.dart';
import '../../domain/entities/album_entity.dart';
import '../sources/album_remote_source.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemoteSource remoteSource;

  AlbumRepositoryImpl(this.remoteSource);

  @override
  Future<List<AlbumEntity>> searchAlbums(
    String query, {
    int? limit,
  }) async {
    final results = await remoteSource.searchAlbums(
      query,
      limit: limit,
    );

    return AlbumModel.fromList(results);
  }
}