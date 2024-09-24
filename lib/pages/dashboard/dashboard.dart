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
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
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
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('All', Pallete.lineButton1Color, () {
                // logic for button
                // for later
              }),
              _buildButton('Completed', Pallete.lineButton2Color, () {
                // logic for button
                // for later
              }),
              _buildButton('Incomplete', Pallete.lineButton3Color, () {
                // logic for button
                // for later
              }),
              _buildButton('Pending', Pallete.lineButton4Color, () {
                // logic for button
                // for later
              }),
            ],
          ),
          Expanded(
              child: Center(
            child: Text(
              isSelected[0] ? 'tasks' : 'clients',
            ),
          ))
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
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          backgroundColor: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: const Size(80, 50),
        ),
      ),
    );
  }
}
