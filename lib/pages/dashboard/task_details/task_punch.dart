import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/reached_location.dart';
import 'package:page_transition/page_transition.dart';

// 300 m not visible
class TaskPunch extends StatefulWidget {
  const TaskPunch({super.key});

  @override
  State<TaskPunch> createState() => TaskPunchState();
}

class TaskPunchState extends State<TaskPunch> {
  Color _buttonColor = const Color.fromARGB(173, 149, 149, 143); // before delay
  double _fillWidth = 0;
  final double _containerWidth = 350;
  bool _showLocations = false;
  bool _showDistance = false;

  @override
  void initState() {
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        _buttonColor = Pallete.activeButtonColor;
        _fillWidth = _containerWidth * 0.7;
        _showLocations = true;
        _showDistance = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDashApp(title: 'Task Details'),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'House no 123 Plus Cross Street',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                // for 70 % container to be filled
                child: Stack(
                  children: [
                    Container(
                      width: _fillWidth,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Pallete.mainFontColor,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    if (_showDistance)
                      Positioned(
                        left: _fillWidth - 35,
                        top: 25,
                        child: Text(
                          '300m',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // after delay location below rectangle
              if (_showLocations)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Start location',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(Factory)',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'End location',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(Client Location)',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              const SizedBox(
                height: 60,
              ),

              Container(
                width: double.infinity,
                height: 48,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                            child: ReachedLocation(),
                            type: PageTransitionType.fade,
                          ));
                    },
                    child: const Text(
                      'REACHED TO LOCATION',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
