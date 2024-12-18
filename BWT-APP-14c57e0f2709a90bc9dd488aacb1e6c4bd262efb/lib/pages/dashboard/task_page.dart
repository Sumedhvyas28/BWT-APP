import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_details.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Map<String, dynamic>? taskData;
  bool isLoading = true;
  int? selectedSegment = 0;
  List<dynamic> filteredTasks = []; // Add a list to store filtered tasks

  Map<int, Color> segmentColors = {
    0: Colors.blue, // "All" tasks color
    1: Colors.red, // "Incompleted" tasks color
    2: Colors.orange, // "Pending" tasks color
    3: Colors.green, // "Completed" tasks color
  };
  void _onSegmentChanged(int? newValue) {
    setState(() {
      selectedSegment = newValue;

      if (taskData != null && taskData!['message'] is List) {
        List<dynamic> tasks = taskData!['message'];

        switch (selectedSegment) {
          case 0:
            filteredTasks = tasks;
            break;
          case 1:
            filteredTasks = tasks
                .where((task) =>
                    task['completion_status'] == 'Partially Completed')
                .toList();
            break;
          case 2:
            filteredTasks = tasks
                .where((task) => task['completion_status'] == 'Pending')
                .toList();
            break;
          case 3:
            filteredTasks = tasks
                .where((task) => task['completion_status'] == 'Fully Completed')
                .toList();
            break;
          default:
            filteredTasks = tasks;
            break;
        }
      } else {
        filteredTasks = [];
      }
    });
  }

  @override
  void initState() {
    super.initState();

    fetchTaskData();
  }

  Future<void> fetchTaskData() async {
    final url = Uri.parse(
        'https://bmscrmnew.bmscg.com:7070/api/method/field_service_management.api.get_maintenance');

    try {
      final response = await http.get(url, headers: {
        'Authorization': '${GlobalData().token}',
        'Content-Type': 'application/json'
      });

      print('Response status: ${response.statusCode}');
      print('Response status: ${GlobalData().token}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          taskData = json.decode(response.body);
          isLoading = false;
          _onSegmentChanged(selectedSegment);
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
        body: RefreshIndicator(
          onRefresh: () async {
            await fetchTaskData();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSlidingSegmentedControl<int>(
                  thumbColor: segmentColors[selectedSegment] ?? Colors.blue,
                  backgroundColor: Colors.grey.shade200,
                  groupValue: selectedSegment,
                  children: {
                    0: Text(
                      "All",
                      style: TextStyle(
                          color: selectedSegment == 0
                              ? Colors.white
                              : Colors.black),
                    ),
                    1: Text(
                      "Incomplete",
                      style: TextStyle(
                          color: selectedSegment == 1
                              ? Colors.white
                              : Colors.black),
                    ),
                    2: Text(
                      "Pending",
                      style: TextStyle(
                          color: selectedSegment == 2
                              ? Colors.white
                              : Colors.black),
                    ),
                    3: Text(
                      "Completed",
                      style: TextStyle(
                          color: selectedSegment == 3
                              ? Colors.white
                              : Colors.black),
                    ),
                  },
                  onValueChanged: _onSegmentChanged,
                ),
              ),
              Expanded(
                child: isLoading
                    ? Center(
                        child: LoadingAnimationWidget.waveDots(
                          color: Pallete.mainFontColor,
                          size: 70,
                        ),
                      )
                    : filteredTasks.isNotEmpty
                        ? _buildTasks(filteredTasks)
                        : Center(child: Text('No tasks available')),
              ),
            ],
          ),
        ));
  }

  Widget _buildTasks(List<dynamic> tasks) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        print('/////////////');
        print('/////////////');
        print(task);
        print('/////////////');
        print('/////////////');
        print(task['start_time']);

        final mntcTime =
            task['start_time'] != null && task['start_time'].startsWith('9')
                ? task['start_time'].substring(0, 4)
                : task['start_time']?.substring(0, 5) ?? 'No Time';
        final endTime =
            task['end_time'] != null && task['end_time'].startsWith('9')
                ? task['end_time'].substring(0, 4)
                : task['end_time']?.substring(0, 5) ?? 'No Time';

        final name = task['name'];
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
                      endTime,
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

                const SizedBox(width: 10),

                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetails(
                            task: name,
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
                                    // Handle button click logic if needed
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (task[
                                                'completion_status'] ==
                                            'Fully Completed')
                                        ? Colors.green // Color for completed
                                        : (task['completion_status'] ==
                                                'Partially Completed')
                                            ? Colors
                                                .red // Color for incomplete (or partially completed)
                                            : (task['completion_status'] ==
                                                    'Pending')
                                                ? Colors
                                                    .orange // Color for pending
                                                : Pallete
                                                    .lineButton4Color, // Default color for other statuses
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    minimumSize: const Size(40, 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    _getStatusText(task[
                                        'completion_status']), // Display the status text based on the condition
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
                                Expanded(
                                  child: Text(
                                    'Created by  :   ${task['owner']}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
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
                                    data:
                                        '${task['description'] ?? 'No description available'}',
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

  String _getStatusText(String completionStatus) {
    switch (completionStatus) {
      case 'All':
        return 'All';
      case 'Fully Completed':
        return 'Completed'; // Change Fully Completed to Complete
      case 'Partially Completed':
        return 'Incomplete'; // Change Partially Completed to Incomplete
      case 'Pending':
        return 'Pending'; // Keep Pending as Pending

      default:
        return completionStatus; // Default case for unknown status
    }
  }
}
