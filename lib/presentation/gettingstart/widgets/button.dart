import 'package:flutter/material.dart';
import 'package:wiz_player/common/appnavigation/app_navigation.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';

class Button extends StatelessWidget {
  final String lable;
  final Widget page;
  const Button({super.key, required this.lable, required this.page});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppNavigation.pushReplacement(context, page);
      },
      child: Text(lable, style: TextStyle(fontSize: 20)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.lightBackground,
        elevation: 6,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      ),
    );
  }
}
