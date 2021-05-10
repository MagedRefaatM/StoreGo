import 'package:flutter/material.dart';
import 'dart:async';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer navigateToLoginTimer;

  void delayTheThread() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/login_page');
  }

  _SplashState() {
    delayTheThread();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/splash.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
