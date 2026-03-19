abstract class PlaylistDetailEvent {}

class LoadPlaylistDetails extends PlaylistDetailEvent {
  final String playlistId;
  final String limit;

  LoadPlaylistDetails(this.playlistId, this.limit);
}
