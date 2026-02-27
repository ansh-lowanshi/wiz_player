import '../../domain/entities/artist_entity.dart';

class ArtistModel extends ArtistEntity {
  ArtistModel({
    required super.id,
    required super.name,
    required super.role,
    required super.imageUrl,
    required super.url,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    final images = (json['image'] as List?) ?? [];

    return ArtistModel(
      id: json['id'] as String? ?? 'Unknown',
      name: json['name'] as String? ?? 'Unknown',
      role: json['role'] as String? ?? 'Unknown',
      url: json['url'] as String? ?? 'Unknown',
      imageUrl: images.isNotEmpty ? images.last['url'] : '',
    //   imageUrl: images.isNotEmpty
    // ? (images.last['url'] as String? ?? '')
    // : '',
    );
  }

  static List<ArtistModel> fromList(List list) {
    return list
        .map((e) => ArtistModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
