import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:flutter_application_1/view_model/location_post.dart';
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
  final UserSession _userSession = UserSession();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for splash screen delay
    await Future.delayed(const Duration(seconds: 4));

    // Check if user is logged in
    final isLoggedIn = await _userSession.isLoggedIn();

    if (isLoggedIn) {
      // Start location updates
      final featureView = context.read<FeatureView>();
      context.read<LocationViewModel>().startLocationUpdates(featureView);

      // Navigate to home
      context.go('/home');
    } else {
      // Navigate to onboarding
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/gif/splash_intro.gif',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
