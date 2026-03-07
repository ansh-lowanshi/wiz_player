import 'package:wiz_player/domain/entities/artist_detail_entity.dart';

import '../entities/artist_entity.dart';

abstract class ArtistRepository {
  Future<List<ArtistEntity>> searchArtists(String query, {int? limit});

  Future<ArtistDetailEntity> searchArtistById(String id);
}
