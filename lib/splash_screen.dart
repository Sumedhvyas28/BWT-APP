import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';

// fully replacable splash screen

// just for placeholder purpose

// todo ---> splash screen animation riv or json format animations

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _eclipseShrinking = false;
  bool _logoJumpingAboveCenter = false;
  bool _logoMovingBackToCenter = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _eclipseShrinking = true;
      });

      Timer(const Duration(seconds: 1), () {
        setState(() {
          _logoJumpingAboveCenter = true;
        });

        Timer(const Duration(seconds: 1), () {
          setState(() {
            _logoMovingBackToCenter = true;
          });

          Timer(const Duration(seconds: 1), () {
            GoRouter.of(context).go('/onboarding');
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: _eclipseShrinking ? 0 : 300,
              height: _eclipseShrinking ? 0 : 300,
              decoration: BoxDecoration(
                color: Pallete.mainFontColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: _logoJumpingAboveCenter
                ? mediaSize.height / 2 - 150
                : _logoMovingBackToCenter
                    ? mediaSize.height / 2 - 50
                    : mediaSize.height / 2 - 50,
            left: mediaSize.width / 2 - 50,
            child: AnimatedOpacity(
              opacity: _eclipseShrinking ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/logos/logo.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
