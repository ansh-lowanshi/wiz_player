import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiz_player/core/config/theme/app_theme.dart';
import 'package:wiz_player/core/config/theme/bloc/theme_bloc.dart';
import 'package:wiz_player/presentation/splash/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, thememode) {
          return MaterialApp(
            title: 'Flutter Demo',
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
