import 'package:wiz_player/domain/entities/album_detail_entity.dart';

class AlbumDetailState {
  final bool isLoading;
  final AlbumDetailEntity? album;
  final String? error;

  AlbumDetailState({this.isLoading = false, this.album, this.error});

  AlbumDetailState copyWith({
    bool? isLoading,
    AlbumDetailEntity? album,
    String? error,
  }) {
    return AlbumDetailState(
      isLoading: isLoading ?? this.isLoading,
      album: album ?? this.album,
      error: error,
    );
  }
}
