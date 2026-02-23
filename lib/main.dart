import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/core/config/theme/app_theme.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_bloc.dart';
import 'package:wiz_player/data/repo/album_repo_impl.dart';
import 'package:wiz_player/data/repo/artist_repo_impl.dart';
import 'package:wiz_player/data/repo/song_repo_impl.dart';
import 'package:wiz_player/data/sources/album_remote_source.dart';
import 'package:wiz_player/data/sources/artist_remote_source.dart';
import 'package:wiz_player/data/sources/song_remote_source.dart';
import 'package:wiz_player/presentation/search/bloc/search_bloc.dart';
import 'package:wiz_player/presentation/splash/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final songRemoteSource = SongRemoteSource();
    final albumRemoteSource = AlbumRemoteSource();
    final artistRemoteSource = ArtistRemoteSource();

    final songRepository = SongRepositoryImpl(songRemoteSource);
    final albumRepository = AlbumRepositoryImpl(albumRemoteSource);
    final artistRepository = ArtistRepositoryImpl(artistRemoteSource);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(
          create: (_) => SearchBloc(
            songRepo: songRepository,
            albumRepo: albumRepository,
            artistRepo: artistRepository,
          ),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, thememode) {
          return MaterialApp(
            title: 'WizPlayer',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            themeMode: thememode,
            home: Splash(),
          );
        },
      ),
    );
  }
}
