abstract class ArtistDetailEvent {}

class LoadArtistDetail extends ArtistDetailEvent {
  final String artistId;

  LoadArtistDetail(this.artistId);
}