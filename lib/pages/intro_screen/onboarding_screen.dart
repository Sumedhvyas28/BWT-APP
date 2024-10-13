import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';

import 'package:flutter_application_1/pages/intro_screen/intro_screen_1.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_screen_2.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_screen_3.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_small_page1.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_small_page2.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_small_page3.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> introPages;
    if (screenHeight <= 800) {
      introPages = const [
        IntroSmallPage1(),
        IntroSmallPage2(),
        IntroSmallPage3(),
      ];
    } else {
      introPages = const [
        IntroPage1(),
        IntroPage2(),
        IntroPage3(),
      ];
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPageIndex = index;
                onLastPage = (index == 2);
              });
            },
            children: introPages,
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: introPages.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 7,
                  dotWidth: 5,
                  spacing: 10,
                  expansionFactor: 7,
                  activeDotColor: Pallete.mainFontColor,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (currentPageIndex == 0) {
                      _controller.jumpToPage(2);
                    } else {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    currentPageIndex == 0 ? 'SKIP' : 'BACK',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (onLastPage) {
                      context.go('/login');
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    onLastPage ? 'LET\'S GET STARTED' : 'NEXT',
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
