import 'package:wiz_player/domain/entities/song_entity.dart';

class PlayerState {
  final bool isLoading;
  final SongEntity? song;
  final String? error;
  final bool isPlaying;

  PlayerState({this.isLoading = false, this.song, this.error, this.isPlaying = false});

  PlayerState copyWith({bool? isLoading, SongEntity? song, String? error, bool? isPlaying}) {
    return PlayerState(
      isLoading: isLoading ?? this.isLoading,
      song: song ?? this.song,
      error: error,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
