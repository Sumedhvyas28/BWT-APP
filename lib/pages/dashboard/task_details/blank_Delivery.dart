import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_punch.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class BlankDeliveryPage extends StatefulWidget {
  const BlankDeliveryPage({super.key});

  @override
  State<BlankDeliveryPage> createState() => _BlankDeliveryPageState();
}

class _BlankDeliveryPageState extends State<BlankDeliveryPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
            child: TaskPunch(),
            type: PageTransitionType.fade,
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomDashApp(title: 'Task Details'),
      body: Center(
        child:
            Lottie.asset('assets/animations/1.json', width: 300, height: 300),
      ),
    );
  }
}
