import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wiz_player/data/model/album_model.dart';
import 'package:wiz_player/data/model/artist_model.dart';
import 'package:wiz_player/data/model/song_model.dart';
import 'package:wiz_player/domain/repo/album_repo.dart';
import 'package:wiz_player/domain/repo/artist_repo.dart';
import 'package:wiz_player/domain/repo/song_repo.dart';
import 'package:wiz_player/presentation/search/bloc/search_evet.dart';
import 'package:wiz_player/presentation/search/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SongRepository songRepo;
  final AlbumRepository albumRepo;
  final ArtistRepository artistRepo;
  SearchBloc({
    required this.songRepo,
    required this.albumRepo,
    required this.artistRepo,
  }) : super(SearchState()) {
    on<SearchRequest>(_onSearch);
  }

  Future<void> _onSearch(SearchRequest event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
        songs: [],
        albums: [],
        artists: [],
        error: null,
      ),
    );
    try {
      switch (event.filter) {
        case "Songs":
          final songs = await songRepo.searchSongs(event.query,limit: 20);
          emit(state.copyWith(isLoading: false, songs: songs));
          break;
        case "Albums":
          final albums = await albumRepo.searchAlbums(event.query);
          emit(state.copyWith(isLoading: false, albums: albums));
          break;
        case "Artist":
          final artists = await artistRepo.searchArtists(event.query);
          emit(state.copyWith(isLoading: false, artists: artists));
          break;
        default:
          final result = await songRepo.searchAll(event.query);

          final data = result["data"];

          final songsJson = data["songs"]["results"] as List;
          final albumsJson = data["albums"]["results"] as List;
          final artistsJson = data["artists"]["results"] as List;

          final songs = songsJson.map((e) => SongModel.fromJson(e)).toList();

          final albums = albumsJson.map((e) => AlbumModel.fromJson(e)).toList();

          final artists = artistsJson
              .map((e) => ArtistModel.fromJson(e))
              .toList();

          emit(
            state.copyWith(
              isLoading: false,
              songs: songs,
              albums: albums,
              artists: artists,
            ),
          );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
