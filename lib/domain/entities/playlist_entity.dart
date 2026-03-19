class PlayListEntity {
  final String id;
  final String name;
  final String imageUrl;
  final String language;
  final String? songCount;

  const PlayListEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.language,
    required this.songCount,
  });
}
