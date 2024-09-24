import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_screen_1.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_screen_2.dart';
import 'package:flutter_application_1/pages/intro_screen/intro_screen_3.dart';
import 'package:flutter_application_1/pages/blank_page.dart';
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
            bottom: 150,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.indigo,
                ),
              ),
            ),
          ),


          Positioned(
            bottom: 30,
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
                  child: Text(currentPageIndex == 0 ? 'SKIP' : 'BACK'),
                ),

                GestureDetector(
                  onTap: () {
                    if (onLastPage && !showDone) {
                      setState(() {
                        showDone = true;
                      });
                    } else if (onLastPage && showDone) {
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BlankPage(),
                        ),
                      );
                    } else {
                      
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(onLastPage && showDone ? 'LET GET STARTED' : 'NEXT'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
