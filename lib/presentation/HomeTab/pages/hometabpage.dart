import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:wiz_player/common/appnavigation/app_navigation.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/presentation/HomeTab/pages/artists_page.dart';
import 'package:wiz_player/presentation/HomeTab/pages/for_you_page.dart';
import 'package:wiz_player/presentation/HomeTab/pages/most_played_page.dart';
import 'package:wiz_player/presentation/HomeTab/pages/recently_played_page.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tabText('For you'),
                _tabButton(context, ForYouPage()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tabText('Recently Played'),
                _tabButton(context, RecentlyPlayedPage()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tabText('Most Played'),
                _tabButton(context, MostPlayedPage()),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tabText('Artists'),
                _tabButton(context, ArtistsPage()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _tabText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget _tabButton(BuildContext context, Widget destination) {
  return TextButton(
    onPressed: () {
      AppNavigation.push(context, destination);
    },
    style: TextButton.styleFrom(foregroundColor: AppColors.primary),
    child: Row(
      children: [
        Text('See All', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 5,),
        Icon(Icons.arrow_forward_ios,size: 12,)
      ],
    ),
  );
}
