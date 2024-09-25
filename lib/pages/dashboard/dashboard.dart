import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/client_page.dart';
import 'package:flutter_application_1/pages/dashboard/task_page.dart';

//pending
// dashboard bottom navbar
// styling not perfect

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
          icon: const Icon(Icons.menu),
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
            icon: const Icon(Icons.search),
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
            padding: const EdgeInsets.symmetric(vertical: 20),
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
                  minHeight: 44,
                  minWidth: 104,
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Tasks'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Clients/Sites'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 2),
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
              child: isSelected[0] ? const TasksPage() : ClientsPage(),
            ),
          ),
        ],
      ),
    );
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
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(80, 50),
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
