import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({super.key});

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container( child: _tabs()),
    );
  }
}

Widget _tabs() {
  return DynamicTabBarWidget(
    labelColor: AppColors.primary,
    indicatorColor: AppColors.primary,
    labelPadding: EdgeInsets.symmetric(horizontal: 12),
    isScrollable: false,
    showBackIcon: false,
    showNextIcon: false,
    physics: BouncingScrollPhysics(),
    dynamicTabs: [
      TabData(
        index: 0,
        title: Tab(text: 'Suggested'),
        content: _buildSuggestionTab(),
      ),
      TabData(
        index: 1,
        title: Tab(text: 'Songs'),
        content: _buildTabContent('Songs'),
      ),
      TabData(
        index: 2,
        title: Tab(text: 'Artists'),
        content: _buildTabContent('Artists'),
      ),
      TabData(
        index: 3,
        title: Tab(text: 'Albums'),
        content: _buildTabContent('Albums'),
      ),
    ],
    onTabControllerUpdated: (TabController p1) {},
  );
}

Widget _buildSuggestionTab() {
  return Center(child: Text('Suggestion page'));
}

Widget _tabText(String text) {
  return Text(text);
}

Widget _buildTabContent(String tab) {
  return Center(child: Text(tab));
}
