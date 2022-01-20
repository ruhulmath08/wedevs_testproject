import 'package:flutter/material.dart';
import 'package:wedevs_testproject/routing/routing_constants.dart';
import 'package:wedevs_testproject/screens/home/home_screen.dart';
import 'package:wedevs_testproject/screens/sign_in/sign_in.dart';
import 'package:wedevs_testproject/screens/sign_up/sign_up.dart';

//name routing for control app routing
Route<MaterialPageRoute>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    //login
    case signInScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignInScreen(
          title: signInScreenTitle,
        ),
      );

    //sign_up
    case signUpScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(
          title: signUpScreenTitle,
        ),
      );

    //home
    case homeScreenRoute:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(
          title: homeScreenTitle,
        ),
      );

    default:
      return null;
  }
}
