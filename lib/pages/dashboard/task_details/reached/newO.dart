import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/error2.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/reason.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/web.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/dashboard.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/add_symptoms.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/alert.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/blank2.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/error_page.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/look_symptoms.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/upload_image/service.dart';
import 'package:flutter_application_1/view_model/checktree.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Newo extends StatefulWidget {
  const Newo({
    super.key,
    required this.task,
  });
  final String task;

  @override
  State<Newo> createState() => _NewoState();
}

class _NewoState extends State<Newo> {
  bool _isPunchPressed = false;
  bool _isPunchOutPressed = false;
  bool isRescheduled = false;
  bool isImageThere = false;
  String _isPunchOutMessage = '';
  Map<String, dynamic>? taskData;
  bool isLoadingTwo = true;
  List<Map<String, dynamic>> items = [];
  List<Map<String, dynamic>> symptoms = [];
  List<bool> isSelected = [];
  String isImageUploade = "";
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  final TextEditingController noteController = TextEditingController();

  bool get allSelected => isSelected.every((selected) => selected);

  @override
  void initState() {
    super.initState();
    _loadNote(); // Load any additional notes

    fetchTaskData(); // Fetch data on initialization
  }

  Future<void> fetchTaskData() async {
    if (widget.task.isEmpty) return;

    print('Fetching task data for: ${widget.task}');

    final String url =
        'https://bmscrmnew.bmscg.com:7070/api/method/field_service_management.api.get_maintenance_?name=${widget.task}';

    setState(() {
      // isLoadingTwo = true;
      taskData = null;
    });

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': '${GlobalData().token}',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          taskData = data['message'];
          parseTaskData(taskData);
          _isPunchPressed = taskData?['latest_punch_in']?.isNotEmpty ?? false;
          _isPunchOutPressed =
              taskData?['latest_punch_out']?.isNotEmpty ?? false;

          // Update the punch-out message if applicable
          if (_isPunchOutPressed) {
            _isPunchOutMessage =
                "Punched out at ${taskData!['latest_punch_out']}";
          }

          isLoadingTwo = false;
        });
      } else {
        throw Exception('Failed to load task data');
      }
    } catch (e) {
      print('Error occurred: $e');
      setState(() => isLoadingTwo = false);
    }
  }

  void parseTaskData(Map<String, dynamic>? data) {
    if (data == null) return;
    items.clear();
    symptoms.clear();

    final checktreeDescription = data['checktree_description'] ?? {};
    final symptomsTable = data['symptoms_table'] ?? {};

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

    isSelected = items.map((item) => item['work_done'] == 'Yes').toList();
  }

  _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      noteController.text = prefs.getString('note') ?? '';
    });
  }

  _saveNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('note', noteController.text);
  }

  Future<void> _takePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final name = DateTime.now().millisecondsSinceEpoch.toString();
      final imagePath = '${directory.path}/$name.jpg';

      final File storedImage = await File(image.path).copy(imagePath);

      setState(() {
        _imageFile = storedImage;
      });

      print("Image saved at: ${storedImage.path}");
    } else {
      print("No image selected.");
    }
  }

  void _uploadImage(BuildContext context) async {
    if (_imageFile != null) {
      try {
        String maintenanceVisit = taskData?['name'];

        await Provider.of<FeatureView>(context, listen: false)
            .postImageWithMaintenanceVisit(maintenanceVisit, _imageFile!);

        final viewModel = Provider.of<FeatureView>(context, listen: false);

        if (viewModel.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${viewModel.errorMessage}')),
          );
        } else {
          isImageThere = true;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image uploaded successfully')),
          );
          setState(() {
            _imageFile = null;
          });

          await fetchTaskData();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
    }
  }

  @override
  void dispose() {
    _saveNote();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visiter_name = taskData?['name'];

    final w = MediaQuery.of(context).size.width;
    List getSymptomsForItemCode(String itemCode) {
      return symptoms.where((item) => item['item_code'] == itemCode).toList();
    }

    List getChecktreeForItemCode(String itemCode) {
      return items.where((item) => item['name'] == itemCode).toList();
    }

    if (isLoadingTwo) {
      return Center(child: CircularProgressIndicator());
    }

    String? lastDisplayedProductCode;
    void _handlePunchOut() {
      if (allSelected && _isPunchPressed && isImageThere) {
        print(taskData!['latest_punch_out']);
        setState(() {
          _isPunchOutPressed = true;
          _isPunchOutMessage =
              "Punched out at ${taskData!['latest_punch_out']} ";

          Future.delayed(Duration(seconds: 3), () async {
            await fetchTaskData();
            setState(() {
              print("Task data refreshed: ${taskData!['latest_punch_in']}");
            });
            final featureView =
                Provider.of<FeatureView>(context, listen: false);
            await featureView.punchOutRepo(visiter_name);
            print(visiter_name);

            if (featureView.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(featureView.message!),
              ));
            }

            Navigator.push(
              context,
              PageTransition(
                child: blankNewPage(),
                type: PageTransitionType.fade,
              ),
            );
          });
        });
      } else {
        if (!_isPunchPressed) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ErrorPage()),
          );
        } else if (!isImageThere) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Error2Page()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlertPage(name: taskData?['name']),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: CustomDashApp(title: 'Task Details'),
      backgroundColor: Colors.white,
      body: isLoadingTwo
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : RefreshIndicator(
              onRefresh: () async {
                print('Refreshing task data...');
                await fetchTaskData();
              },
              child: taskData == null
                  ? Center(
                      child: isLoadingTwo
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 10),
                                Text(
                                  'Refreshing task data...',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            )
                          : Text(
                              'Refreshing task data...',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),

                            Html(
                              data:
                                  taskData?['delivery_addres'] ?? 'no address',
                              style: {
                                "body": Style(
                                  fontSize: FontSize(20),
                                  fontWeight: FontWeight.bold,
                                ),
                              },
                            ),

                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: double.infinity,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Pallete.mainFontColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Center(
                              child: Text(
                                'Location Reached',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isPunchPressed
                                      ? Pallete.punchButtonColor
                                      : Pallete.activeButtonColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: _isPunchPressed ||
                                        taskData?['completion_status'] ==
                                            'Fully Completed'
                                    ? null
                                    : () async {
                                        print(taskData!['latest_punch_in']);

                                        setState(() {
                                          _isPunchPressed =
                                              true; // Set the button to pressed
                                        });

                                        final featureView =
                                            Provider.of<FeatureView>(context,
                                                listen: false);

                                        await featureView.punchInRepo(
                                            visiter_name); // API call
                                        print(visiter_name);

                                        if (featureView.message != null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(featureView.message!),
                                          ));

                                          await fetchTaskData();
                                          setState(() {
                                            print(
                                                "Task data refreshed: ${taskData!['latest_punch_in']}");
                                          });
                                        }
                                      },
                                child: Text(
                                  _isPunchPressed
                                      ? 'PUNCHED IN'
                                      : 'PUNCH IN FOR THE JOB',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            if (_isPunchPressed)
                              Center(
                                child: Text(
                                  "Punched in at ${taskData!['latest_punch_in']}", // Update message
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.punchButtonColor,
                                  ),
                                ),
                              ),

                            SizedBox(
                              height: 10,
                            ),
                            // product list
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Checklist",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Pallete.mainFontColor),
                                    ),
                                    // const SizedBox(height: 3),
                                    // const Divider(
                                    //   thickness: 4,
                                    // ),
                                    // const SizedBox(height: 10),
                                    Column(
                                      children: items
                                          .asMap()
                                          .entries
                                          .where(
                                              (entry) => !isSelected[entry.key])
                                          .map((entry) {
                                        int index = entry.key;
                                        var item = entry.value;

                                        bool showProductCode =
                                            item['item_code'] !=
                                                lastDisplayedProductCode;
                                        if (showProductCode) {
                                          lastDisplayedProductCode =
                                              item['item_code'];
                                        }

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (showProductCode)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        item['item_code'] ??
                                                            'No Item Code',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Pallete
                                                                .mainFontColor),
                                                      ),
                                                      // SizedBox(
                                                      //   width: w * .37,
                                                      // ),
                                                      Spacer(),
                                                      IconButton(
                                                        onPressed: () {
                                                          List
                                                              selectedSymptoms =
                                                              getSymptomsForItemCode(
                                                                  item[
                                                                      'item_code']);

                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              child:
                                                                  LookForSymptoms(
                                                                task:
                                                                    selectedSymptoms,
                                                              ),
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons.search,
                                                          color: Pallete
                                                              .mainFontColor,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          List
                                                              selectedSymptoms =
                                                              getChecktreeForItemCode(
                                                                  item['name']);
                                                          print(
                                                              'lolflfqlflqflqfl');
                                                          print(
                                                              getChecktreeForItemCode(
                                                                  item[
                                                                      'name']));
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              child:
                                                                  AddSymptoms(
                                                                task:
                                                                    selectedSymptoms,
                                                              ),
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .add_circle_rounded,
                                                          color: Pallete
                                                              .mainFontColor,
                                                          size: 20,
                                                        ),
                                                      ),
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
                                                                      Navigator.of(
                                                                              context)
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
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Text(
                                                    item['item_name'] ??
                                                        'No name',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            CheckboxListTile(
                                              activeColor:
                                                  Pallete.mainFontColor,
                                              hoverColor: Pallete.mainFontColor,
                                              checkboxShape:
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              value: isSelected[index],
                                              title: Text(
                                                item['heading'] ?? 'No heading',
                                              ),
                                              onChanged: _isPunchPressed
                                                  ? (val) async {
                                                      setState(() {
                                                        isSelected[index] =
                                                            val ?? false;
                                                      });

                                                      String name =
                                                          items[index]['name'];
                                                      String status = items[
                                                                  index]
                                                              ['collected'] ??
                                                          'no';

                                                      await Checktree
                                                          .updateChecktreeRepo(
                                                        name,
                                                        work_done: "yes",
                                                      );
                                                    }
                                                  : null, // Disable checkbox if _isPunchPressed is false
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 10),
                                    // const Divider(
                                    //   thickness: 2,
                                    // ),
                                    const SizedBox(height: 10),

                                    // Check if any items are selected to show "Completed Task" heading
                                    if (isSelected.contains(true))
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text(
                                          "Completed Task",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Pallete.mainFontColor,
                                          ),
                                        ),
                                      ),

                                    Wrap(
                                      children: items
                                          .asMap()
                                          .entries
                                          .where(
                                              (entry) => isSelected[entry.key])
                                          .map((entry) {
                                        int index = entry.key;
                                        var item = entry.value;
                                        return SizedBox(
                                          width: double.infinity,
                                          child: Card(
                                            elevation: 3,
                                            // color: Colors.deepPurpleAccent,
                                            color: Pallete.mainFontColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    item['item_code'],
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    item['heading'] ??
                                                        'No heading',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: _isPunchPressed
                                                        ? () async {
                                                            setState(() {
                                                              isSelected[
                                                                      index] =
                                                                  false;
                                                            });
                                                            String name =
                                                                items[index]
                                                                    ['name'];

                                                            await Checktree
                                                                .updateChecktreeRepo(
                                                                    name,
                                                                    work_done:
                                                                        "no");
                                                          }
                                                        : null,
                                                    child: const Icon(
                                                      Icons
                                                          .delete_forever_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // attachment card
                            Card(
                              color: Colors.white,
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Attachment for the Task Completion',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, // Aligns children to the start
                                      children: [
                                        // First icon: To trigger the camera for taking a picture
                                        InkWell(
                                          onTap: () async {
                                            await _takePicture(); // Trigger the camera when the icon is tapped
                                          },
                                          child: const Icon(
                                            Icons.add_circle_rounded,
                                            color: Pallete.iconAddColor,
                                          ),
                                        ),
                                        const SizedBox(
                                            width:
                                                10), // Adds space between the icons (optional)

                                        // Text that says "Upload Pic"
                                        const Text(
                                          "Add attachment",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),

                                        const SizedBox(
                                            width:
                                                10), // Adds space between the text and the image (optional)

                                        if (_imageFile != null)
                                          Container(
                                            width: 100,
                                            height: 200.0,
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                _imageFile!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),

                                        const Spacer(),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.upload_file,
                                            color: Pallete.iconAddColor,
                                          ),
                                          onPressed: () {
                                            _uploadImage(context);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Attachment List',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    if (taskData != null &&
                                        taskData!['attachments'] != null &&
                                        taskData!['attachments'] is List &&
                                        taskData!['attachments'].isNotEmpty)
                                      ListView.builder(
                                        itemCount:
                                            taskData!['attachments'].length,
                                        shrinkWrap:
                                            true, // Ensures it fits inside a parent widget
                                        physics:
                                            NeverScrollableScrollPhysics(), // Makes it scroll with the parent
                                        itemBuilder: (context, index) {
                                          // Reverse the order of the attachments
                                          final reversedAttachment =
                                              taskData!['attachments']
                                                  .reversed
                                                  .toList()[index];
                                          final imageUrl =
                                              'https://bmscrmnew.bmscg.com:7070${reversedAttachment['image']}';

                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          WebViewScreen(
                                                        url: imageUrl,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  '${index + 1}. Attachment',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    else
                                      Text('No attachments available'),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            // note container
                            Card(
                              color: Colors.white,
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Note',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: TextField(
                                        controller: noteController,
                                        maxLines: null,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Pallete.mainFontColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: _isPunchOutPressed
                                          ? null
                                          : () async {
                                              String note = noteController.text;

                                              await Checktree.technicianNotes(
                                                  visiter_name, note, context);
                                            },
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 30,
                            ),

                            // bottom punch out button
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isPunchOutPressed
                                      ? Pallete.disabledBtnColor
                                      : Pallete.redBtnColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed:
                                    taskData!['latest_punch_out']?.isEmpty ??
                                            true
                                        ? _handlePunchOut
                                        : null,
                                child: Text(
                                  _isPunchOutPressed
                                      ? 'PUNCHED OUT'
                                      : 'PUNCH OUT',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),

                            if (_isPunchOutPressed)
                              Center(
                                child: Text(
                                  _isPunchOutMessage,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Pallete.redBtnColor,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
            ),
    );
  }
}
