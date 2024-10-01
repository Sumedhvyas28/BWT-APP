import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/client_page.dart';
import 'package:flutter_application_1/pages/dashboard/custom_navbar.dart';
import 'package:flutter_application_1/pages/dashboard/task_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<bool> isSelected = [true, false];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          ),
          title: const Text(
            'DASHBOARD',
            style: TextStyle(
              color: Pallete.mainFontColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_active_sharp),
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
              padding:
                  const EdgeInsets.only(top: 3, left: 8, right: 8, bottom: 2),
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
                  constraints: const BoxConstraints(
                    minHeight: 31,
                    minWidth: 91,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton('All', Pallete.lineButton1Color, () {}),
                _buildButton('Completed', Pallete.lineButton2Color, () {}),
                _buildButton('Incomplete', Pallete.lineButton3Color, () {}),
                _buildButton('Pending', Pallete.lineButton4Color, () {}),
              ],
            ),
            Expanded(
              child: Center(
                child: isSelected[0] ? const TasksPage() : const ClientsPage(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavbar(
          selectedIndex: _selectedIndex,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ));
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.white),
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

  Widget _buildClients() {
    return const Center(
      child: Text(
        'Clients/Sites content goes here.',
        style: TextStyle(
          fontSize: 18,
          color: Pallete.mainFontColor,
        ),
      ),
    );
  }
}
