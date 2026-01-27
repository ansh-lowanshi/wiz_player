import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/common/appnavigation/app_navigation.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_bloc.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_event.dart';
import 'package:wiz_player/presentation/FavouriteTab/pages/favouritepage.dart';
import 'package:wiz_player/presentation/HomeTab/pages/hometabpage.dart';
import 'package:wiz_player/presentation/PlaylistTab/pages/playlistpage.dart';
import 'package:wiz_player/presentation/ProfileTab/pages/profilepage.dart';
import 'package:wiz_player/presentation/homepage/pages/debug.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.music_note_outlined, color: AppColors.primary),
            SizedBox(width: 10),
            Text('WizPlayer'),
          ],
        ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  AppNavigation.push(context, SongDebugPage());
                },
                icon: Icon(Icons.search),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ToggleTheme());
                },
                icon: Icon(Icons.brightness_6),
              ),
            ],
          ),
        ],
        toolbarHeight: 65,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: IndexedStack(
          index: _currentIndex,
          children: [
            HomeTabPage(),
            FavouritePage(),
            PlaylistPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : AppColors.lightBackground,
        selectedItemColor: AppColors.primary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_play),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
