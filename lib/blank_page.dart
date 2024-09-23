import 'package:flutter/material.dart';
import 'package:flutter_application_1/pallete.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Pallete.mainFontColor,
      body: Center(
         child: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.white,fontSize: 30,),
            children: <TextSpan>[
              TextSpan(text: 'Hello User,\n'),
              TextSpan(text: 'Please Login!,\n')
            ]
          ),
         )
         )
      );
    
  }
}