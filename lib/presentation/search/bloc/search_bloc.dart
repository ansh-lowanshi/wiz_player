import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:wiz_player/data/model/album_model.dart';
import 'package:wiz_player/data/model/artist_model.dart';
import 'package:wiz_player/data/model/song_model.dart';
import 'package:wiz_player/domain/repo/album_repo.dart';
import 'package:wiz_player/domain/repo/artist_repo.dart';
import 'package:wiz_player/domain/repo/global_search_repo.dart';
import 'package:wiz_player/domain/repo/song_repo.dart';
import 'package:wiz_player/presentation/search/bloc/search_evet.dart';
import 'package:wiz_player/presentation/search/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SongRepository songRepo;
  final AlbumRepository albumRepo;
  final ArtistRepository artistRepo;
  final GlobalSearchRepo globalSearchRepo;
  SearchBloc({
    required this.songRepo,
    required this.albumRepo,
    required this.artistRepo,
    required this.globalSearchRepo,
  }) : super(SearchState()) {
    on<SearchRequest>(_onSearch);
    on<ClearSearch>((event, emit) {
      emit(SearchState());
    });
  }

  Future<void> _onSearch(SearchRequest event, Emitter<SearchState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
        songs: [],
        albums: [],
        artists: [],
        globalSearch: null,
        error: null,
      ),
    );
    try {
      switch (event.filter) {
        case "Songs":
          final songs = await songRepo.searchSongs(event.query, limit: 20);
          emit(state.copyWith(isLoading: false, songs: songs));
          break;
        case "Albums":
          final albums = await albumRepo.searchAlbums(event.query);
          emit(state.copyWith(isLoading: false, albums: albums));
          break;
        case "Artists":
          final artists = await artistRepo.searchArtists(event.query);
          emit(state.copyWith(isLoading: false, artists: artists));
          break;
        default:
          final globalSearchResult = await globalSearchRepo.searchAll(
            event.query,
          );

          emit(
            state.copyWith(
              isLoading: false,
              globalSearch: globalSearchResult,
              songs: [],
              albums: [],
              artists: [],
            ),
          );
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
