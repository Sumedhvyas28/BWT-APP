import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserSession _authService = UserSession();

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  // Checks the login status after a delay and navigates accordingly
  Future<void> _navigateAfterDelay() async {
    // Simulate a splash screen delay of 3 seconds
    await Future.delayed(const Duration(seconds: 5));

    // Check if the user is logged in
    final isLoggedIn = await _authService.isLoggedIn();

    // Navigate based on login status
    if (isLoggedIn) {
      // If logged in, go to the general DashboardPage
      context.go('/home');
    } else {
      // If not logged in, go to the LoginPage
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/gif/splash_intro.gif', // Path to your GIF asset
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
