import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_screen_1.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_screen_2.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_screen_3.dart';
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
  bool showDone = false;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Define breakpoints
    double screenWidth = MediaQuery.of(context).size.width;

    double bottomIndicatorPosition;
    double buttonBottomPosition;
    double buttonFontSize;

    if (screenWidth <= 360) {
      // Small phone
      bottomIndicatorPosition = 150;
      buttonBottomPosition = 30;
      buttonFontSize = 14;
    } else if (screenWidth <= 600) {
      // Medium phone
      bottomIndicatorPosition = 180;
      buttonBottomPosition = 40;
      buttonFontSize = 16;
    } else {
      // Large phone
      bottomIndicatorPosition = 200;
      buttonBottomPosition = 50;
      buttonFontSize = 18;
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
                if (index != 2) {
                  showDone = false;
                }
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Positioned(
            bottom: bottomIndicatorPosition,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(
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
            bottom: buttonBottomPosition,
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
                    style: TextStyle(fontSize: buttonFontSize),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (onLastPage && !showDone) {
                      setState(() {
                        showDone = true;
                      });
                    } else if (onLastPage && showDone) {
                      context.go('/login');
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    onLastPage && showDone ? 'LET\'S GET STARTED' : 'NEXT',
                    style: TextStyle(fontSize: buttonFontSize),
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
