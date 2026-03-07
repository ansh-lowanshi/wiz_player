// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wiz_player/domain/entities/artist_detail_entity.dart';

class ArtistDetailState {
  final bool isLoading;
  final ArtistDetailEntity? artistData;
  final String? error;

  ArtistDetailState({this.isLoading = false, this.artistData, this.error});

  ArtistDetailState copyWith({
    bool? isLoading,
    ArtistDetailEntity? artistData,
    String? error,
  }) {
    return ArtistDetailState(
      isLoading: isLoading ?? this.isLoading,
      artistData: artistData ?? this.artistData,
      error: error,
    );
  }
}
