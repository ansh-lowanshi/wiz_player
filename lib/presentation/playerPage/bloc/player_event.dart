abstract class PlayerEvent {}

class LoadSong extends PlayerEvent{
  final String songId;

  LoadSong(this.songId);
}

class PlayPause extends PlayerEvent{}

class PlayNext extends PlayerEvent{}

class PlayPrevious extends PlayerEvent{}