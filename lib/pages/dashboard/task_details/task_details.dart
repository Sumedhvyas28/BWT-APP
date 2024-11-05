import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/blank_Delivery.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class TaskDetails extends StatefulWidget {
  final Map<String, dynamic>? task; // Accept task data as a parameter

  const TaskDetails({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  Map<String, dynamic>? taskData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      // Use passed data if available
      taskData = widget.task;
      isLoading = false;
    } else {
      // Otherwise, fetch data from API
      fetchTaskData();
    }
  }

  Future<void> fetchTaskData() async {
    final url = Uri.parse(
      'https://686f-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.get_maintenance',
    );

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

  final List<String> items = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
  ];

  // Track selection status
  List<bool> isSelected = List.filled(3, false); // Adjust the size as needed

  void _checkAndNavigate() {
    if (isSelected.contains(false)) {
      // Show alert dialog if no checkbox is selected
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
            child: Text(
              "No Selection",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
            "Please select all the items before proceeding.",
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "OK",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    } else {
      Navigator.push(
        context,
        PageTransition(
          child: BlankDeliveryPage(),
          type: PageTransitionType.fade,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = taskData?['message']?[2];
    final mntcTime = task['mntc_time']?.substring(0, 8) ??
        'No Time'; // Extracting "HH:MM:SS" format

    // double screenWidth = MediaQuery.of(context).size
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomDashApp(title: 'Task Details'),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator()) // Show loader when loading
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // 1st container
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.20, // Responsive height
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
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task[
                                          'name'], // Use null-aware operator for safety
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Customer Service Address',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Html(
                                          data: task['address_display'] ?? '',
                                          style: {
                                            "body": Style(
                                              fontSize: FontSize(18),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          },
                                        ),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 1st card
                        Expanded(
                          child: SizedBox(
                            height: 121,
                            child: Card(
                              elevation: 3,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task['contact_display'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.phone),
                                        SizedBox(width: 5),
                                        Text(
                                          task['contact_mobile'],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.email),
                                        SizedBox(width: 5),
                                        Text(
                                          task['contact_email'],
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // 2nd card
                        Expanded(
                          child: SizedBox(
                            height: 121,
                            child: Card(
                              elevation: 3,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Working Schedule',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                              width: 2,
                                              height:
                                                  35, // Set height according to your layout
                                              color: Colors.black),
                                          SizedBox(width: 3),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  Text(
                                                    mntcTime,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  Text(
                                                    mntcTime,
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                                'Customer Query (Issues)',
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.28, // Responsive height,
                      child: Card(
                        elevation: 3,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 18, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Maintenance Description',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                task['maintenance_description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Html(
                                    data: task['description'],
                                    style: {
                                      "p": Style(),
                                      // Add more styles as needed for other HTML elements
                                    },
                                  ),
                                ),
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
                                'Spare Items',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: isSelected[index],
                                          onChanged: (newBool) {
                                            setState(() {
                                              isSelected[index] = newBool!;
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: Text(
                                            items[index],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete.mainFontColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                        onPressed: _checkAndNavigate,
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
