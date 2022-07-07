import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'home_screen.dart';


class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/GetUpLogo.png',
        splashIconSize: 132.0,
        nextScreen: const HomePage(),
        backgroundColor: Color(0xFF001432),
        pageTransitionType: PageTransitionType.bottomToTop,
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
