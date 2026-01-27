class SongEntity {
  final String id;
  final String name;
  final int duration;
  final String language;
  final String label;
  final int? playCount;
  final String albumName;
  final String artistName;
  final String imageUrl;
  final String audioUrl;

  const SongEntity({
    required this.id,
    required this.name,
    required this.duration,
    required this.language,
    required this.label,
    required this.playCount,
    required this.albumName,
    required this.artistName,
    required this.imageUrl,
    required this.audioUrl,
  });
}