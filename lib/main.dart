import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigation/app_navigation.dart';
// import 'pages/intro_screen/onboarding_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppNavigation.router,
    );
  }
}
