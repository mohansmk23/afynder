import 'dart:async';

import 'package:afynder/constants/colors.dart';
import 'package:afynder/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splashscreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool startAnimation = false;
  AnimationController controller;
  Animation<double> animation;

  void startAnimationTimer() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startAnimationTimer();

    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation = new Tween(begin: 68.0, end: 36.0).animate(
        new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn))
      ..addListener(() {
        setState(() {});
      });
    Future.delayed(Duration(seconds: 3), () => controller?.forward());
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Dashboard())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.themeOrange,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              left: startAnimation ? 68.0 : null,
              duration: Duration(milliseconds: 500),
              child: AnimatedContainer(
                width: startAnimation ? 120.0 : 300.0,
                height: startAnimation ? 120.0 : 300.0,
                duration: Duration(milliseconds: 500),
                child: Image.asset('assets/logo.png'),
              ),
            ),
            Visibility(
              visible: startAnimation,
              child: Positioned(
                left: 178.0,
                child: Center(
                  child: Text(
                    'aFynder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: animation.value,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
