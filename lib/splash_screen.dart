import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:nozit/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nozit/pages/LoginPage.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Lottie.asset('assets/planner.json'),

        // Column(
        //   children: [
        //     Image.asset('assets/workplace.png'),
        //     const Text('WorkPlace', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),)
        //   ],
        // ),
        backgroundColor: Colors.black,
        nextScreen: const LoginScreen(),
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
