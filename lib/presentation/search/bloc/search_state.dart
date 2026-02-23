import 'package:wiz_player/domain/entities/album_entity.dart';
import 'package:wiz_player/domain/entities/artist_entity.dart';
import 'package:wiz_player/domain/entities/song_entity.dart';

class SearchState {
  final bool isLoading;
  final List<SongEntity> songs;
  final List<AlbumEntity> albums;
  final List<ArtistEntity> artists;
  final String? error;

  SearchState({
    this.isLoading = false,
    this.songs = const [],
    this.albums = const [],
    this.artists = const [],
    this.error,
  });

  SearchState copyWith({
    bool? isLoading,
    List<SongEntity>? songs,
    List<AlbumEntity>? albums,
    List<ArtistEntity>? artists,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      songs: songs ?? this.songs,
      albums: albums ?? this.albums,
      artists: artists ?? this.artists,
      error: error,
    );
  }
}
