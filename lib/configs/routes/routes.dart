import 'package:eduwise/configs/routes/routes_name.dart';
import 'package:eduwise/screens/signin/signin-view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

//SignInScreen routes name

      case RoutesName.signInScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SignInScreen());

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