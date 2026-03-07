import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/domain/repo/artist_repo.dart';
import 'package:wiz_player/presentation/artistDetailPage/bloc/artist_detail_event.dart';
import 'package:wiz_player/presentation/artistDetailPage/bloc/artist_detail_state.dart';

class ArtistDetailBloc extends Bloc<ArtistDetailEvent, ArtistDetailState> {
  final ArtistRepository repository;

  ArtistDetailBloc(this.repository) : super(ArtistDetailState()) {
    on<LoadArtistDetail>(_onLoadArtistData);
  }

  Future<void> _onLoadArtistData(
    LoadArtistDetail event,
    Emitter<ArtistDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final artistData = await repository.searchArtistById(event.artistId);
      emit(state.copyWith(isLoading: false, artistData: artistData));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
