import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wedevs_testproject/routing/routing_constants.dart';

//before the login page visible we will display some content to the user i.e. company logo, message etc.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<Timer> startTime() async {
    const _duration = Duration(seconds: 3); //display the splash screen for 3 seconds
    return Timer(_duration, navigationPage);
  }

  Future navigationPage() async {
    Navigator.of(context).pushReplacementNamed(signInScreenRoute);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/wedevs_logo.png'),
      ),
    );
  }
}
