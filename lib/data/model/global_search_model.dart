import '../../domain/entities/global_search_entity.dart';

class GlobalSearchModel extends GlobalSearchEntity {
  GlobalSearchModel({
    required super.songs,
    required super.albums,
    required super.artists,
  });

  factory GlobalSearchModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    final songsJson = (data?['songs']?['results'] as List?) ?? [];

    final albumsJson = (data?['albums']?['results'] as List?) ?? [];

    final artistsJson = (data?['artists']?['results'] as List?) ?? [];

    return GlobalSearchModel(
      songs: songsJson.map((e) {
        final images = (e['image'] as List?) ?? [];
        return SearchSongItem(
          id: e['id']?.toString() ?? '',
          title: e['title']?.toString() ?? '',
          artistName: e['primaryArtists']?.toString() ?? '',
          imageUrl: images.isNotEmpty
              ? images.last['url']?.toString() ?? ''
              : '',
        );
      }).toList(),

      albums: albumsJson.map((e) {
        final images = (e['image'] as List?) ?? [];
        return SearchAlbumItem(
          id: e['id']?.toString() ?? '',
          title: e['title']?.toString() ?? '',
          artistName: e['primaryArtists']?.toString() ?? '',
          imageUrl: images.isNotEmpty
              ? images.last['url']?.toString() ?? ''
              : '',
        );
      }).toList(),

      artists: artistsJson.map((e) {
        final images = (e['image'] as List?) ?? [];
        return SearchArtistItem(
          id: e['id']?.toString() ?? '',
          title: e['title']?.toString() ?? '',
          imageUrl: images.isNotEmpty
              ? images.last['url']?.toString() ?? ''
              : '',
        );
      }).toList(),
    );
  }
}
