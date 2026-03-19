import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wiz_player/core/config/theme/app_theme.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_bloc.dart';

import 'package:wiz_player/data/repo/album_repo_impl.dart';
import 'package:wiz_player/data/repo/artist_repo_impl.dart';
import 'package:wiz_player/data/repo/global_search_repo_impl.dart';
import 'package:wiz_player/data/repo/playlist_repo_impl.dart';
import 'package:wiz_player/data/repo/song_repo_impl.dart';

import 'package:wiz_player/data/sources/album_remote_source.dart';
import 'package:wiz_player/data/sources/artist_remote_source.dart';
import 'package:wiz_player/data/sources/global_search_remote_source.dart';
import 'package:wiz_player/data/sources/playlist_remote_source.dart';
import 'package:wiz_player/data/sources/song_remote_source.dart';

import 'package:wiz_player/domain/repo/album_repo.dart';
import 'package:wiz_player/domain/repo/artist_repo.dart';
import 'package:wiz_player/domain/repo/global_search_repo.dart';
import 'package:wiz_player/domain/repo/playlist_repo.dart';
import 'package:wiz_player/domain/repo/song_repo.dart';
import 'package:wiz_player/presentation/albumDetailPage/bloc/album_detail_bloc.dart';
import 'package:wiz_player/presentation/artistDetailPage/bloc/artist_detail_bloc.dart';
import 'package:wiz_player/presentation/homepage/pages/base_page.dart';
import 'package:wiz_player/presentation/playerPage/bloc/player_bloc.dart';
import 'package:wiz_player/presentation/playlistDetailPage.dart/bloc/playlist_detail_bloc.dart';

import 'package:wiz_player/presentation/search/bloc/search_bloc.dart';
import 'package:wiz_player/presentation/splash/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('app_storage');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SongRepository>(
          create: (_) => SongRepositoryImpl(SongRemoteSource()),
        ),
        RepositoryProvider<AlbumRepository>(
          create: (_) => AlbumRepositoryImpl(AlbumRemoteSource()),
        ),
        RepositoryProvider<ArtistRepository>(
          create: (_) => ArtistRepositoryImpl(ArtistRemoteSource()),
        ),
        RepositoryProvider<PlaylistRepo>(
          create: (_) => PlaylistRepoImpl(PlaylistRemoteSource()),
        ),
        RepositoryProvider<GlobalSearchRepo>(
          create: (_) => GlobalSearchRepoImpl(GlobalSearchRemoteSource()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(create: (_) => ThemeBloc()),
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(
              songRepo: context.read<SongRepository>(),
              albumRepo: context.read<AlbumRepository>(),
              artistRepo: context.read<ArtistRepository>(),
              playlistRepo: context.read<PlaylistRepo>(),
              globalSearchRepo: context.read<GlobalSearchRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => PlayerBloc(context.read<SongRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                AlbumDetailBloc(context.read<AlbumRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                ArtistDetailBloc(context.read<ArtistRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                PlaylistDetailBloc(context.read<PlaylistRepo>()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              // home:  Splash(),
              home:  HomePage(),
            );
          },
        ),
      ),
    );
  }
}
