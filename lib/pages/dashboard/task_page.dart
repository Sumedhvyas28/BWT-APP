import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/models/product_description.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_details.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

String _removeHtmlTags(String? htmlText) {
  if (htmlText == null) return '';
  final document =
      html_parser.parse(htmlText); // Corrected to use html_parser.parse
  return document.body?.text ?? '';
}

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

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
    final url = Uri.parse(
        'https://00b6-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.get_maintenance');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'token 45a6b57c35c5a19:8fd12351c087d9e',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        isLoading = false;
      });
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
    final tasks = taskData['message']; // This is an array of task objects

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final mntcTime = task['mntc_time']?.substring(0, 8) ??
            'No Time'; // Extracting "HH:MM:SS" format
        Html(
          data: 'Description: ${task['description']}',
          style: {
            "html": Style(
              fontSize: FontSize(11), // Adjust font size as needed
            ),
          },
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mntcTime,
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
                      mntcTime,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                // Divider
                const SizedBox(width: 10),
                // Column(
                //   children: [
                //     Container(
                //       width: 2,
                //       height: 50, // Set height according to your layout
                //       color: (task['completion_status'] == 'completed')
                //           ? Colors.green // Color for completed
                //           : (task['completion_status'] == 'incomplete')
                //               ? Colors.red // Color for incomplete
                //               : Pallete
                //                   .lineButton4Color, // Default color for pending
                //     ),
                //   ],
                // ),
                const SizedBox(width: 10),

                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetails(
                            task: null,
                          ),
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task['subject'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        task['mntc_date'],
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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
                                    backgroundColor: (task[
                                                'completion_status'] ==
                                            'completed')
                                        ? Colors.green // Color for completed
                                        : (task['completion_status'] ==
                                                'incomplete')
                                            ? Colors.red // Color for incomplete
                                            : Pallete
                                                .lineButton4Color, // Default color for pending
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    minimumSize: const Size(40, 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    task[
                                        'completion_status'], // Displaying the status text
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.person, size: 20),
                                const SizedBox(width: 10),
                                Text(
                                  'Created by  : ${task['owner']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.info, size: 20),
                                const SizedBox(width: 10),
                                Text(
                                  'Description : ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Html(
                                    data: '${task['description']}',
                                  ),
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.location_pin, size: 20),
                                const SizedBox(width: 10),
                                Text(
                                  'Location  :',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Html(
                                    data: ' ${task['address_display']}',
                                  ),
                                )),
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
