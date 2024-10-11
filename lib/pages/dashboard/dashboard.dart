import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/drawer.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/client_page.dart';
import 'package:flutter_application_1/pages/dashboard/task_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Dashboard'),
      drawer: DrawerPage(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            height: 4.5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.02,
                vertical: screenSize.height * 0.005),
            child: Center(
              child: ToggleButtons(
                isSelected: isSelected,
                onPressed: (index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                  });
                },
                selectedColor: Colors.white,
                fillColor: Colors.blue,
                borderColor: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                constraints: BoxConstraints(
                  minHeight: screenSize.height * 0.04,
                  minWidth: screenSize.width * 0.2,
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Text('Tasks'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Text('Clients/Sites'),
                  ),
                ],
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildButton(
                        'All', Pallete.lineButton1Color, () {}, constraints),
                    _buildButton('Completed', Pallete.lineButton2Color, () {},
                        constraints),
                    _buildButton('Incomplete', Pallete.lineButton3Color, () {},
                        constraints),
                    _buildButton('Pending', Pallete.lineButton4Color, () {},
                        constraints),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Center(
              child: isSelected[0] ? const TasksPage() : const ClientsPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed,
      BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth * 0.2,
      child: ElevatedButton(
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(91, 31),
        ),
      ),
    );
  }
}
