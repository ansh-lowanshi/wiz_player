class AlbumEntity {
  final String id;
  final String name;
  final String url;
  final int year;
  final String language;
  final String artistName;
  final String imageUrl;
  final int? playCount;

  const AlbumEntity({
    required this.id,
    required this.name,
    required this.url,
    required this.year,
    required this.language,
    required this.artistName,
    required this.imageUrl,
    required this.playCount,
  });
}