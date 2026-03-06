abstract class AblumDetailEvent {}

class LoadAlbumDetail extends AblumDetailEvent {
  final String albumId;

  LoadAlbumDetail(this.albumId);
}