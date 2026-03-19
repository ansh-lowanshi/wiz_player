import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/domain/repo/playlist_repo.dart';
import 'package:wiz_player/presentation/playlistDetailPage.dart/bloc/playlist_detail_event.dart';
import 'package:wiz_player/presentation/playlistDetailPage.dart/bloc/playlist_detail_state.dart';

class PlaylistDetailBloc
    extends Bloc<PlaylistDetailEvent, PlaylistDetailState> {
  final PlaylistRepo repository;

  PlaylistDetailBloc(this.repository) : super(PlaylistDetailState()) {
    on<LoadPlaylistDetails>(_onLoadPlaylistDetails);
  }

  Future<void> _onLoadPlaylistDetails(
    LoadPlaylistDetails event,
    Emitter<PlaylistDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final playlist = await repository.searchPlaylistById(
        event.playlistId,
        event.limit,
      );
      emit(state.copyWith(isLoading: false, playlist: playlist));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
