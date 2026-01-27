import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:wiz_player/presentation/gettingstart/pages/gettingStarted.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.scale(
        childWidget: Image.asset('assets/images/applogo.png'),
        duration: Duration(seconds: 5),
        animationDuration: Duration(seconds: 3),
        nextScreen: Gettingstarted(),
      ),
    );
  }
}
