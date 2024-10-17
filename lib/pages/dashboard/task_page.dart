import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_details.dart';
import 'package:page_transition/page_transition.dart';

// pending
// fully logic for schedule task had to be done

class TasksPage extends StatelessWidget {
  TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildTasks(),
    );
  }

  // Dummy data  FOR NOW MAKE MODELS FOR THESE
  final List<Map<String, dynamic>> tasks = [
    {
      'status': 'completed',
      'time': '1:00 PM',
      'endTime': '2:00 PM',
      'buttonColor': Colors.green,
      'buttonText': 'Completed'
    },
    {
      'status': 'pending',
      'time': '3:00 PM',
      'endTime': '4:00 PM',
      'buttonColor': Colors.red,
      'buttonText': 'Pending'
    },
    {
      'status': 'in-progress',
      'time': '6:00 PM',
      'endTime': '7:00 PM',
      'buttonColor': Colors.orange,
      'buttonText': 'Delayed'
    },
  ];

  Widget _buildTasks() {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task['time'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 2,
                      height: 10,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      task['endTime'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: TaskDetails(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.account_circle_rounded),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Schedule Task',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      'Monday, July 1',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Task',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle button click logic
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: task['buttonColor'],
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    minimumSize: const Size(40, 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    task['buttonText'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.account_circle_rounded,
                                        size: 16),
                                    SizedBox(width: 5),
                                    Text('Created by  : Sumedh',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.info, size: 16),
                                    SizedBox(width: 5),
                                    Text('Description:  Lab Sample Collection',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 16),
                                    SizedBox(width: 5),
                                    Text(
                                        'Location     :  48A Cua Bac,Tan Phu Dist',
                                        style: TextStyle(fontSize: 11)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
