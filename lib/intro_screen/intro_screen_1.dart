import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.only(top: 93.0), 

            child: Image.asset(
              'assets/logos/logo.png',
              height: 96, 
              fit: BoxFit.contain,
            ),
          ),
        ),
        

        
          SvgPicture.asset('assets/images/first12.svg', height: 300,width: 200,),
          const SizedBox(height: 20), 
    
    
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0), 
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black), 
              children: <TextSpan>[
                TextSpan(text: 'Easy Job Scheduling\n', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Get all your daily jobs organized in one place. Check your schedule and focus on delivering quality service.\n'),
                TextSpan(text: 'Place your tasks in order and stay focused.\n'), 
                TextSpan(text: 'Deliver quality service!'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
