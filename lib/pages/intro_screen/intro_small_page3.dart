import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';

class IntroSmallPage3 extends StatefulWidget {
  const IntroSmallPage3({super.key});

  @override
  State<IntroSmallPage3> createState() => _IntroSmallPage3State();
}

class _IntroSmallPage3State extends State<IntroSmallPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Image.asset(
                  'assets/logos/logo.png',
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Field Service Management',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Pallete.mainFontColor,
                  ),
                ),
              ],
            ),
          ),
          // Main image
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/third_3.png',
              height: 300,
            ),
          ),
          // Text content
          Positioned(
            top: 430,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Easy Job Scheduling',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'Get all your daily jobs organized in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Place your tasks in order and stay focused.',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Deliver quality service!',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
