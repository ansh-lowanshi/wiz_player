import '../entities/artist_entity.dart';

abstract class ArtistRepository {
  Future<List<ArtistEntity>> searchArtists(String query, {int? limit});
}
