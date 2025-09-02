import 'package:eduwise/configs/routes/routes_name.dart';
import 'package:eduwise/screens/signin/signin_view.dart';
import 'package:eduwise/screens/signup/signup_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

//SignInScreen routes name

      case RoutesName.signInScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignInScreen());

      case RoutesName.signUpScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignUpScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}