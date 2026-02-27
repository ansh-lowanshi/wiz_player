import 'package:wiz_player/domain/entities/global_search_entity.dart';

abstract class GlobalSearchRepo {
  Future<GlobalSearchEntity> searchAll(String query);
}