import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/core/config/theme/app_colors.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_bloc.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_event.dart';
import 'package:wiz_player/presentation/gettingstart/widgets/button.dart';
import 'package:wiz_player/presentation/homepage/pages/home_page.dart';
import 'package:wiz_player/presentation/signup/pages/signup.dart';

class Gettingstarted extends StatelessWidget {
  const Gettingstarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            child: IconButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleTheme());
              },
              icon: Icon(Icons.brightness_6),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              "WizPlayer",
              style: TextStyle(color: AppColors.primary, fontSize: 60),
            ),
            SizedBox(height: 16),
            Text(
              'Enjoy Listing To Music',
              style: TextStyle(
                color: AppColors.cream,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'WizPlayer is a free and open-source music player that uses a third-party database, and all associated licenses are held by the respective provider.',
              style: TextStyle(fontSize: 14, height: 1.6),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: Button(lable: "Let's get Started...", page: HomePage()),
                ),
              ],
            ),
            SizedBox(height: 55),
          ],
        ),
      ),
    );
  }
}
