import 'package:wiz_player/data/model/artist_model.dart';
import 'package:wiz_player/domain/entities/artist_detail_entity.dart';
import 'package:wiz_player/domain/repo/artist_repo.dart';
import '../../domain/entities/artist_entity.dart';
import '../sources/artist_remote_source.dart';

class ArtistRepositoryImpl implements ArtistRepository {
  final ArtistRemoteSource remoteSource;

  ArtistRepositoryImpl(this.remoteSource);

  @override
  Future<List<ArtistEntity>> searchArtists(String query, {int? limit}) async {
    final results = await remoteSource.searchArtists(query, limit: limit);

    return ArtistModel.fromList(results);
  }

  @override
  Future<ArtistDetailEntity> searchArtistById(String id) async {
    final result = await remoteSource.searchArtistById(id);

    return result;
  }
}
