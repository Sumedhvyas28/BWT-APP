import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/blank_Delivery.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/map.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_punch.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;

class TaskDetails extends StatefulWidget {
  final Map<String, dynamic>? task;

  const TaskDetails({super.key, required this.task});

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
      taskData = widget.task;
      isLoading = false;
    } else {
      // fetchTaskData();
      throw Exception('Failed to load task data');
    }
  }

  // Future<void> fetchTaskData() async {
  //   final url = Uri.parse(
  //     'https://403a-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.get_maintenance',
  //   );

  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Authorization': 'token 45a6b57c35c5a19:8fd12351c087d9e',
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         taskData = json.decode(response.body);
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       throw Exception('Failed to load task data');
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  List<bool> isSelected = [];

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final task = taskData;
    final mntcTime = task?['mntc_time']?.substring(0, 8) ??
        'No Time'; // Extracting "HH:MM:SS" format
    print(task?['spare_items']);

    // Initialize spareItems and isSelected here
    List<dynamic> spareItems = task?['spare_items'] ?? [];
    if (isSelected.length != spareItems.length) {
      isSelected = List<bool>.filled(spareItems.length, false);
    }

    void checkAndNavigate() {
      if (isSelected.contains(false)) {
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
            child: TaskPunch(
              task: task,
            ),
            type: PageTransitionType.fade,
          ),
        );
      }
    }

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
                                      task?[
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
                                          data: task?['address_display'] ?? '',
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        child: mapPage(),
                                        type: PageTransitionType.fade,
                                      ),
                                    );
                                  },
                                  child: Image.asset(
                                    'assets/images/cal.png',
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    fit: BoxFit.cover,
                                  ),
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
                                      task?['contact_display'],
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
                                          task?['contact_mobile'],
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
                                          task?['contact_email'],
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
                      width: double.infinity,

                      height: MediaQuery.of(context).size.height *
                          0.15, // Responsive height,
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
                      width: double.infinity,
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
                                task?['maintenance_description'] ??
                                    'no description available',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              // Expanded(
                              //   child: SingleChildScrollView(
                              //     child: Html(
                              //       data: task?['customer_address'],
                              //       style: {
                              //         "p": Style(),
                              //         // Add more styles as needed for other HTML elements
                              //       },
                              //     ),
                              //   ),
                              // ),
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              const Text(
                                'Spare Items',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 200, // Fixed height for ListView
                                child: ListView.builder(
                                  itemCount: spareItems.length,
                                  itemBuilder: (context, index) {
                                    final item = spareItems[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            value: isSelected[index],
                                            onChanged: (newBool) {
                                              setState(() {
                                                isSelected[index] =
                                                    newBool ?? false;
                                              });
                                            },
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item?['item_code'] ??
                                                      'No Item Code',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  item?['description'] ??
                                                      'No Description',
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                  maxLines:
                                                      3, // Limit text display for clarity
                                                  overflow: TextOverflow
                                                      .ellipsis, // Trim long text
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
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
                        onPressed: checkAndNavigate,
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
