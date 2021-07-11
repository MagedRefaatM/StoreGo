import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void delayTheThread() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, '/login_page');
  }

  @override
  void initState() {
    delayTheThread();
    super.initState();
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
