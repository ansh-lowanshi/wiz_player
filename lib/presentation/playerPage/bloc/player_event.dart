abstract class PlayerEvent {}

class LoadSong extends PlayerEvent{
  final String songId;

  LoadSong(this.songId);
}

class PlayPause extends PlayerEvent{}