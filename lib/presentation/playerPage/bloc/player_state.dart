import 'package:wiz_player/domain/entities/song_entity.dart';

class PlayerState {
  final bool isLoading;
  final SongEntity? song;
  final String? error;
  final bool isPlaying;
  final Duration position;
  final Duration duration;

  PlayerState({
    this.isLoading = false,
    this.song,
    this.error,
    this.isPlaying = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
  });

  PlayerState copyWith({
    bool? isLoading,
    SongEntity? song,
    String? error,
    bool? isPlaying,
    Duration? position,
    Duration? duration,
  }) {
    return PlayerState(
      isLoading: isLoading ?? this.isLoading,
      song: song ?? this.song,
      error: error,
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
    );
  }
}
