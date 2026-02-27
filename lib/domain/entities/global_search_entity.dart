class GlobalSearchEntity {
  final List<SearchSongItem> songs;
  final List<SearchAlbumItem> albums;
  final List<SearchArtistItem> artists;

  const GlobalSearchEntity({
    required this.songs,
    required this.albums,
    required this.artists,
  });
}

class SearchSongItem {
  final String id;
  final String title;
  final String imageUrl;
  final String artistName;
  

  const SearchSongItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.artistName,
   
  });
}

class SearchAlbumItem {
  final String id;
  final String title;
  final String imageUrl;
  final String artistName;

  const SearchAlbumItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.artistName
  });
}

class SearchArtistItem {
  final String id;
  final String title;
  final String imageUrl;

  const SearchArtistItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}