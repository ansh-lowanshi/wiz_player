import 'package:wiz_player/domain/entities/album_detail_entity.dart';

import '../entities/album_entity.dart';

abstract class AlbumRepository {
  Future<List<AlbumEntity>> searchAlbums(String query, {int? limit});

  Future <AlbumDetailEntity> searchAlbumById(String id);
}
