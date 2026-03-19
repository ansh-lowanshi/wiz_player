import 'package:wiz_player/domain/entities/playlist_detail_entity.dart';

class PlaylistDetailState {
  final bool isLoading;
  final PlaylistDetailEntity? playlist;
  final String? error;

  PlaylistDetailState({this.isLoading = false, this.playlist, this.error});

  PlaylistDetailState copyWith({
    bool? isLoading,
    PlaylistDetailEntity? playlist,
    String? error,
  }) {
    return PlaylistDetailState(
      isLoading: isLoading ?? this.isLoading,
      playlist: playlist ?? this.playlist,
      error: error ?? this.error,
    );
  }
}
