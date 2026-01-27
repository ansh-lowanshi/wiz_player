import '../entities/artist_entity.dart';

abstract class ArtistRepo {
  Future<List<ArtistEntity>> searchArtists(String query, {int? limit});
}
