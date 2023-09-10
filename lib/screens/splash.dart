import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:wits_bus/wrapper.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  void _navigatetohome() async {
    await  Future.delayed(Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Wrapper()));
  }


  @override
  void initState() {
    // TODO: implement initState
    _navigatetohome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/wallpaper.jpeg',
      nextScreen: Wrapper(),
      splashTransition: SplashTransition.scaleTransition,
      splashIconSize: 150,
    );
  }
}
