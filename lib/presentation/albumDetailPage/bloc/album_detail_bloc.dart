import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/domain/repo/album_repo.dart';
import 'package:wiz_player/domain/repo/song_repo.dart';
import 'package:wiz_player/presentation/albumDetailPage/bloc/ablum_detail_event.dart';
import 'package:wiz_player/presentation/albumDetailPage/bloc/album_detail_state.dart';

class AlbumDetailBloc extends Bloc<AblumDetailEvent, AlbumDetailState> {
  final AlbumRepository repository;

  AlbumDetailBloc(this.repository) : super(AlbumDetailState()) {
    on<LoadAlbumDetail>(_onLoadAlbumDetail);
  }

  Future<void> _onLoadAlbumDetail(
    LoadAlbumDetail event,
    Emitter<AlbumDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final album = await repository.searchAlbumById(event.albumId);
      emit(state.copyWith(isLoading: false, album: album));
      
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
