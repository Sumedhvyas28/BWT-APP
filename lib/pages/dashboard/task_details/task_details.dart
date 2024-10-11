import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_punch.dart';

class TaskDetails extends StatefulWidget {
  const TaskDetails({super.key});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  List<bool> isSelected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Task Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // 1st container
              Container(
                height: MediaQuery.of(context).size.height *
                    0.18, // Responsive height
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width *
                          0.04, // Responsive left padding
                      right: MediaQuery.of(context).size.width *
                          0.02, // Responsive right padding
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sumedh Vyas',
                                style: TextStyle(
                                  fontSize: 18, // Keep text size static
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Customer Service Address',
                                style: TextStyle(
                                  fontSize: 12, // Keep text size static
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'House No 3, plus Cross',
                                style: TextStyle(
                                  fontSize: 18, // Keep text size static
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Street, South Vietnam',
                                style: TextStyle(
                                  fontSize: 18, // Keep text size static
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.02),
                          child: Image.asset(
                            'assets/images/cal.png',
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 2 parallel cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 1st card
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sumedh Vyas',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 5),
                                Text('+91 - 1246667395'),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 5),
                                Text('+91 - 1246667395'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 2nd card (copy)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.42,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sumedh Vyas',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 5),
                                Text('+91 - 1246667395'),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 5),
                                Text('+91 - 1246667395'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // New Container with Padding
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 120,
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 18, right: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer Query',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // Container sop
              Container(
                height: 229,
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 18, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Customer Query',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),

                        // Dot Point 1
                        Row(
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. fklfkhwq fqlfqmf qjofqf ;lmqqlf ;q',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Dot Point 2
                        Row(
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // container with checkbox
              Container(
                height: 300,
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Customer Query',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: isSelected[0],
                              onChanged: (newBool) {
                                setState(() {
                                  isSelected[0] = newBool!;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. fklfkhwq fqlfqmf qjofqf ;lmqqlf ;q',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: isSelected[1],
                              onChanged: (newBool) {
                                setState(() {
                                  isSelected[1] = newBool!;
                                });
                              },
                            ),
                            Expanded(
                              child: Text(
                                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Checkbox(
                              value: isSelected[2],
                              onChanged: (newBool) {
                                setState(() {
                                  isSelected[2] = newBool!;
                                });
                              },
                            ),
                            const Expanded(
                              child: Text(
                                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete.mainFontColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TaskPunch(),
                      ),
                    );
                  },
                  child: const Text(
                    'Going For Visit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
