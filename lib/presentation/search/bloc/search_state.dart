import 'package:wiz_player/domain/entities/album_entity.dart';
import 'package:wiz_player/domain/entities/artist_entity.dart';
import 'package:wiz_player/domain/entities/global_search_entity.dart';
import 'package:wiz_player/domain/entities/song_entity.dart';

class SearchState {
  final bool isLoading;
  final List<SongEntity> songs;
  final List<AlbumEntity> albums;
  final List<ArtistEntity> artists;
  final GlobalSearchEntity? globalSearch;
  final String? error;

  SearchState({
    this.isLoading = false,
    this.songs = const [],
    this.albums = const [],
    this.artists = const [],
    this.globalSearch,
    this.error,
  });

  SearchState copyWith({
    bool? isLoading,
    List<SongEntity>? songs,
    List<AlbumEntity>? albums,
    List<ArtistEntity>? artists,
    GlobalSearchEntity? globalSearch,
    String? error,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      songs: songs ?? this.songs,
      albums: albums ?? this.albums,
      artists: artists ?? this.artists,
      globalSearch: globalSearch ?? this.globalSearch,
      error: error,
    );
  }
}
