import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';

class NewMapPage extends StatefulWidget {
  final Map<String, dynamic>? task;

  const NewMapPage({super.key, this.task});

  @override
  State<NewMapPage> createState() => _NewMapPageState();
}

class _NewMapPageState extends State<NewMapPage> {
  Map<String, dynamic>? taskData;

  @override
  void initState() {
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        taskData = widget.task;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(taskData);
    final geolocation = taskData?['geolocation'];
    print(geolocation);

    return Scaffold(
      appBar: CustomAppBar(title: 'map'),
    );
  }
}
