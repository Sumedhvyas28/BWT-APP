import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/constants/pallete.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({super.key});

  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainFontColor,
      body: Center(
        child: RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.white, fontSize: 30),
            children: const <TextSpan>[
              TextSpan(text: 'Hello User,\n'),
              TextSpan(text: 'Please Login!\n'),
            ],
          ),
        ),
      ),
    );
  }
}
