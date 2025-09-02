import 'package:eduwise/provider/sign_in_provider.dart';
import 'package:eduwise/screens/signin/signin-view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';
void main() {
  runApp(const MyApp());
}

/// Root widget with Provider for state management.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Register all app-wide providers here
      providers: [
        ChangeNotifierProvider(create: (_) => SignInProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sign In',
        theme: AppTheme.light, // Centralized theme
        home: const SignInScreen(),
      ),
    );
  }
}
