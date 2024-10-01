import 'package:flutter/material.dart';
import 'package:flutter_application_1/splash_screen.dart';
// import 'pages/intro_screen/onboarding_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
