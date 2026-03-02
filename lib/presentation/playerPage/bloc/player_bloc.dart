import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/domain/repo/song_repo.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_event.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_state.dart';
import 'package:just_audio/just_audio.dart' as audio;

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final SongRepository repository;
  final audio.AudioPlayer _audioPlayer = audio.AudioPlayer();

  PlayerBloc(this.repository) : super(PlayerState()) {
    on<LoadSong>(_onLoadSong);
    on<PlayPause>(_onPlayPause);
  }

  Future<void> _onLoadSong(LoadSong event, Emitter<PlayerState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final song = await repository.serchSongById(event.songId);
      await _audioPlayer.setUrl(song.audioUrl);
      emit(state.copyWith(isLoading: false, song: song));
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

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
