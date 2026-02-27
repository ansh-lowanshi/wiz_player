import 'package:wiz_player/data/model/global_search_model.dart';
import 'package:wiz_player/data/sources/global_search_remote_source.dart';
import 'package:wiz_player/domain/entities/global_search_entity.dart';
import 'package:wiz_player/domain/repo/global_search_repo.dart';

class GlobalSearchRepoImpl implements GlobalSearchRepo {
  final GlobalSearchRemoteSource remoteSource;

  GlobalSearchRepoImpl(this.remoteSource);

  @override
  Future<GlobalSearchEntity> searchAll(String query) async {
    final result = await remoteSource.searchAll(query);

    return GlobalSearchModel.fromJson(result);
  }
}
