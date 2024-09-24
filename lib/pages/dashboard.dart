import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        title: const Row(
          children: [
            Text(
              'DASHBOARD',
              style: TextStyle(
                color: Pallete.mainFontColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            height: 4.5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Center(),
          )
        ],
      ),
    );
  }
}
