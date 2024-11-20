import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/blank_Delivery.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/map.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/new_map.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/task_punch.dart';
import 'package:flutter_application_1/view_model/auth_view_model.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TaskDetails extends StatefulWidget {
  final String task;

  const TaskDetails({super.key, required this.task});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  Map<String, dynamic>? taskData;
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> symptoms = [];
  List<dynamic> spareItems = []; // Change to dynamic to avoid redefinition
  List<bool> isSelected = [];
  bool isLoading = true;
  late FeatureView featureView;
  String buttonText = '';
  Color buttonColor = Pallete.mainFontColor;
  bool isButtonEnabled = true; // Variable to control button state

  @override
  void initState() {
    super.initState();
    featureView = FeatureView();
    _loadCheckboxState();
    fetchTaskData();
  }

  Future<void> _loadCheckboxState() async {
    final loadedStates = await featureView.loadCheckboxState(spareItems.length);
    setState(() {
      isSelected = loadedStates;
    });
  }

  // void fetchInitialData() {
  //   if (widget.task.isNotEmpty) {

  //     fetchTaskData();
  //     print(taskData);
  //   } else {
  //     setState(() => isLoading = false);
  //   }
  // }

  // Function to fetch updated data from API
  Future<void> fetchTaskData() async {
    // Dynamically use widget.task for the task name in the URL
    final String task = widget.task; // Use the task passed to the widget
    final String url =
        'https://5a9d-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.get_maintenance_?name=$task';

    setState(() => isLoading = true); // Show loading indicator during fetch

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization':
            '${GlobalData().token}', // Assuming you have GlobalData().token
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        setState(() {
          taskData =
              json.decode(response.body); // Update taskData with API response
          parseTaskData(taskData); // Parse data after fetching it from the API
          isLoading = false;
          print('loflflqflqflqfl');

          print(taskData);
        });
      } else {
        setState(() => isLoading = false);
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      print('Error occurred: $e');
      setState(() => isLoading = false);
    }
  }

  // Helper function to parse task data into relevant lists
  void parseTaskData(Map<String, dynamic>? data) {
    if (data == null) return;

    final task = data['message'];

    final checktreeDescription = task['checktree_description'] ?? {};
    final symptomsTable = task['symptoms_table'] ?? {};
    spareItems = task['spare_items'] ?? [];

    symptomsTable.forEach((key, value) {
      if (value is List) {
        symptoms.addAll(List<Map<String, dynamic>>.from(value));
      }
    });

    checktreeDescription.forEach((key, value) {
      if (value is List) {
        items.addAll(List<Map<String, dynamic>>.from(value));
      }
    });

    // Initialize isSelected based on the 'collected' status
    isSelected = spareItems.map((item) {
      return item['collected'] == 'yes';
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // final featureView = Provider.of<FeatureView>(context);

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final task = taskData?['message'];
    final mntcTime = task?['mntc_time']?.substring(0, 8) ??
        'No Time'; // Extracting "HH:MM:SS" format

    final visit_name = task['visit_start'];
    final visiter_name = task['name'];

    print('/////////////////////////////////////////////////////');
    print(task['name']);

    // print(task['spare_items']);

    // Initialize spareItems and isSelected here
    if (isSelected.length != spareItems.length) {
      isSelected = List<bool>.filled(spareItems.length, false);
    }
    void checkAndNavigate() async {
      // Check if any checkbox is not selected
      if (isSelected.contains(false)) {
        // Show dialog if not all checkboxes are selected
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
        // If visit_name is not null, enable the button
        if (visit_name != null) {
          print('Visit is not null - enabling the button and navigating.');
          Navigator.push(
            context,
            PageTransition(
              child: NewMapPage(task: task),
              type: PageTransitionType.fade,
            ),
          );
        } else {
          print('Visit is null - calling API with fallback value.');

          final featureViewModel = context.read<FeatureView>();

          await featureViewModel.goingForVisitRepo(visiter_name);
          print(visiter_name);

          if (featureViewModel.isLoading) {
            print("Loading in progress...");
            return; // Exit and wait for loading to complete
          }

          // Verify if the API call was successful
          if (featureViewModel.message != null &&
              featureViewModel.message!.contains("success")) {
            print('lolll');
            Navigator.push(
              context,
              PageTransition(
                child: TaskPunch(task: task),
                type: PageTransitionType.fade,
              ),
            );
          } else {
            print(
                "API call failed or message is null: ${featureViewModel.message}");
            return;
          }
        }
      }
    }

    if (visit_name == null) {
      buttonText = 'Going for visit ';
    } else {
      buttonText = 'Have a look';
    }

    // double screenWidth = MediaQuery.of(context).size
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomDashApp(title: 'Task Details'),
        body: RefreshIndicator(
          onRefresh: () async {
            // Call a function to re-fetch data here
            await fetchTaskData(); // You would define this function to reload your data
          },
          child: isLoading
              ? Center(child: CircularProgressIndicator())
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task?['name'] ?? 'noname',
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
                                              data: task?['address_display']
                                                      ?.toString() ??
                                                  'no address', // Convert to String to ensure non-null
                                              style: {
                                                "body": Style(
                                                  fontSize: FontSize(18),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        MediaQuery.of(context).size.width *
                                            0.02),
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task?['contact_display'] ??
                                              'no contact',
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
                                              task?['contact_mobile'] ??
                                                  'no mobile',
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
                                              task?['contact_email'] ??
                                                  'no email',
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      SizedBox(width: 5),
                                                      Text(
                                                        mntcTime,
                                                        style: TextStyle(
                                                            fontSize: 12),
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
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 18, right: 8, top: 8, bottom: 8),
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
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Html(
                                        data: task?['customer_query']
                                                ?.toString() ??
                                            'No customer query', // Convert to String to ensure non-null
                                        style: {
                                          "body": Style(
                                            fontSize: FontSize(14),
                                          ),
                                        },
                                      ),
                                    ),
                                  ),
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

                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Html(
                                        data: task?['description'] ??
                                            'no description available',
                                        style: {
                                          "body": Style(
                                            fontSize: FontSize(14),
                                          ),
                                        },
                                      ),
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
                                        print(spareItems[index]['collected']);
                                        print('/////////////////////fq..qf.q.');
                                        print(spareItems[index]['name']);
                                        if (isSelected.length !=
                                            spareItems.length) {
                                          isSelected = List<bool>.filled(
                                              spareItems.length, false);
                                        }

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                value: spareItems[index]
                                                        ['collected'] ==
                                                    'yes',
                                                onChanged: visit_name != null
                                                    ? null
                                                    : (newBool) async {
                                                        setState(() {
                                                          spareItems[index][
                                                                  'collected'] =
                                                              newBool == true
                                                                  ? 'yes'
                                                                  : 'no';
                                                        });

                                                        String name =
                                                            spareItems[index]
                                                                ['name'];
                                                        String status = spareItems[
                                                                    index]
                                                                ['collected'] ??
                                                            'no';

                                                        print(
                                                            'Updating spare item: Name: $name, Status: $status');

                                                        await featureView
                                                            .updateSpareItem(
                                                                name, status);

                                                        await featureView
                                                            .saveCheckboxState(
                                                                isSelected);

                                                        if (featureView
                                                                .message !=
                                                            null) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  featureView
                                                                      .message!),
                                                            ),
                                                          );
                                                          print(
                                                              'API Response: ${featureView.message}');
                                                        }
                                                      },
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          item['item_code'] ??
                                                              'No Item Code',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        IconButton(
                                                          icon: Icon(
                                                            Icons.location_on,
                                                            color: Pallete
                                                                .mainFontColor,
                                                          ),
                                                          onPressed: () {
                                                            print(item[
                                                                'item_location']);
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Item Location'),
                                                                  content: Text(
                                                                    item['item_location'] ??
                                                                        'No Item location provided',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                      child: Text(
                                                                          'Close'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                        )
                                                      ],
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
                            onPressed: isButtonEnabled
                                ? checkAndNavigate
                                : null, // Disable the button when `isButtonEnabled` is false
                            child: Text(
                              buttonText,
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
        ));
  }
}
