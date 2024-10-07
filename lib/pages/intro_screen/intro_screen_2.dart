import 'package:flutter/material.dart';


class IntroPage2 extends StatelessWidget {
  const IntroPage2 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned(
            top: 93,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/logos/logo.png',
              height: 96,
              fit: BoxFit.contain,
            ),
          ),

          
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/second_2.png',
              height: 420,
            ),
          ),


         const  Positioned(
            top: 550,
            left: 20, 
            right: 20, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, 
              children: const [
                Text(
                  'Easy Job Scheduling',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15), 
                Text(
                  'Get all your daily jobs organized in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                  
                ),
                Text(
                  'Place your tasks in order and stay focused.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Deliver quality service!',
                  style: TextStyle(fontSize: 16),
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