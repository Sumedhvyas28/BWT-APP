import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_details.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class TasksPage extends StatefulWidget {
  TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Map<String, dynamic>? taskData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTaskData();
  }

  Future<void> fetchTaskData() async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/unknown/2'));
    if (response.statusCode == 200) {
      setState(() {
        taskData = json.decode(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : taskData != null
              ? _buildTasks(taskData!)
              : Center(child: Text('Failed to load data')),
    );
  }

  Widget _buildTasks(Map<String, dynamic> taskData) {
    final task = taskData['data'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: ListView(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      task['year'].toString(),
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
                      task['pantone_value'],
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
                            Row(
                              children: [
                                Icon(Icons.account_circle_rounded),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task['name'],
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      'Year: ${task['year']}',
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
                                    backgroundColor: Color(int.parse(
                                            task['color'].substring(1, 7),
                                            radix: 16) +
                                        0xFF000000),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    minimumSize: const Size(40, 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    'Color: ${task['color']}',
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
                                    Icon(Icons.info, size: 16),
                                    SizedBox(width: 5),
                                    Text('Pantone Value: 17-2031',
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
          SizedBox(height: 20),
          // Center(
          //   child: Text(
          //     taskData['support']['text'],
          //     textAlign: TextAlign.center,
          //     style: TextStyle(color: Colors.grey),
          //   ),
          // ),
        ],
      ),
    );
  }
}
