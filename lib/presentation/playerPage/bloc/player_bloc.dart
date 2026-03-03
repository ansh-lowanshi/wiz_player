import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/data/model/song_model.dart';
import 'package:wiz_player/domain/entities/song_entity.dart';
import 'package:wiz_player/domain/repo/song_repo.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_event.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_state.dart';
import 'package:just_audio/just_audio.dart' as audio;

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final SongRepository repository;
  final audio.AudioPlayer _audioPlayer = audio.AudioPlayer();
  List<SongEntity> _queue = [];
  int _currentIndex = 0;
  bool _isFetchingSuggestions = false;

  StreamSubscription? _PlayerStateSub;
  StreamSubscription? _positionSub;
  StreamSubscription? _durationSub;

  PlayerBloc(this.repository) : super(PlayerState()) {
    on<LoadSong>(_onLoadSong);
    on<PlayPause>(_onPlayPause);
    on<PlayNext>(_onPlayNext);
    on<PlayPrevious>(_onPlayPrevious);

    _PlayerStateSub = _audioPlayer.playerStateStream.listen((playerState) {
      emit(state.copyWith(isPlaying: playerState.playing));

      if (playerState.processingState == audio.ProcessingState.completed) {
        add(PlayNext());
      }
    });

    _positionSub = _audioPlayer.positionStream.listen((position) {
      emit(state.copyWith(position: position));
    });

    _durationSub = _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        emit(state.copyWith(duration: duration));
      }
    });
  }

  Future<void> _onLoadSong(LoadSong event, Emitter<PlayerState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final song = await repository.serchSongById(event.songId);

      _queue.clear();
      _currentIndex = 0;

      _queue.add(song);

      await _audioPlayer.setUrl(song.audioUrl);

      emit(state.copyWith(isLoading: false, song: song));

      await _audioPlayer.play();
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onPlayPause(PlayPause event, Emitter<PlayerState> emit) async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
      emit(state.copyWith(isPlaying: false));
    } else {
      await _audioPlayer.play();
      emit(state.copyWith(isPlaying: true));
    }
  }

  Future<void> _onPlayNext(PlayNext event, Emitter<PlayerState> emit) async {
    if (_currentIndex < _queue.length - 1) {
      _currentIndex++;
      final song = _queue[_currentIndex];

      await _audioPlayer.setUrl(_queue[_currentIndex].audioUrl);
      emit(state.copyWith(song: _queue[_currentIndex]));
      await _audioPlayer.play();

      _manageQueueCleanup();
    } else {
      await _addSuggestions(_queue[_currentIndex]);
      if (_currentIndex < _queue.length - 1) {
        _currentIndex++;
        final song = _queue[_currentIndex];

        await _audioPlayer.setUrl(_queue[_currentIndex].audioUrl);
        emit(state.copyWith(song: _queue[_currentIndex]));
        await _audioPlayer.play();

        _manageQueueCleanup();
      }
    }

    int remaining = _queue.length - _currentIndex - 1;

    if (remaining <= 2) {
      _addSuggestions(_queue[_currentIndex]);
    }

    if (_currentIndex > 8 && _queue.length > 5) {
      _queue.removeRange(0, 5);
      _currentIndex -= 5;
    }
  }

  Future<void> _onPlayPrevious(
    PlayPrevious event,
    Emitter<PlayerState> emit,
  ) async {
    if (_currentIndex > 0) {
      _currentIndex--;
      await _audioPlayer.setUrl(_queue[_currentIndex].audioUrl);
      emit(state.copyWith(song: _queue[_currentIndex]));
      await _audioPlayer.play();
    }
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }

  Future<void> _addSuggestions(SongEntity song) async {
    if (_queue.length >= 20) return;
    if (_isFetchingSuggestions) return;
    try {
      final suggestions = await repository.songSuggestions(song.id);

      final existingIds = _queue.map((e) => e.id).toSet();

      final filtered = suggestions
          .where((s) => !existingIds.contains(s.id))
          .take(5)
          .toList();

      final limited = suggestions.take(5).toList();

      _queue.addAll(filtered);
    } catch (_) {}

    _isFetchingSuggestions = false;
  }

  void _manageQueueCleanup() {
    if (_currentIndex > 8 && _queue.length > 5) {
      _queue.removeRange(0, 5);
      _currentIndex -= 5;
    }
  }
}
