import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
  String _isPunchOutMessage = '';
  Map<String, dynamic>? taskData;
  bool isLoading = true;
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
    _loadNote();

    fetchTaskData(); // Fetch data on initialization
  }

  Future<void> fetchTaskData() async {
    if (widget.task.isEmpty) return;

    print('Fetching task data for: ${widget.task}');

    final String url =
        'https://8656-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.get_maintenance_?name=${widget.task}';

    setState(() => isLoading = true);

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': '${GlobalData().token}', // Your auth token
        'Content-Type': 'application/json'
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          taskData = data['message'];
          parseTaskData(taskData);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load task data');
      }
    } catch (e) {
      print('Error occurred: $e');
      setState(() => isLoading = false);
    }
  }

// Parse task data and clear lists before adding new data
  void parseTaskData(Map<String, dynamic>? data) {
    if (data == null) return;

    // Clear existing lists before adding new data
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

    // Initialize selection states
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image uploaded successfully')),
          );
          setState(() {
            _imageFile = null;
          });
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

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    String? lastDisplayedProductCode;
    void _handlePunchOut() {
      if (allSelected && _isPunchPressed) {
        setState(() {
          _isPunchOutPressed = true;
          _isPunchOutMessage =
              "Punched out at ${TimeOfDay.now().format(context)}"; // Update message
          Future.delayed(Duration(seconds: 3), () async {
            final featureView =
                Provider.of<FeatureView>(context, listen: false);
            await featureView.punchOutRepo(visiter_name);
            print(visiter_name);

            // Handle UI feedback if needed after the punch-in is complete (e.g., show a message)
            if (featureView.message != null) {
              // Optionally show a success or error message from the API response
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            if (!_isPunchPressed) {
              return ErrorPage();
            } else {
              return AlertPage(
                name: taskData?['name'],
              );
            }
          },
        );
      }
    }

    return Scaffold(
        appBar: CustomDashApp(title: 'Task Details'),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            // Call a function to re-fetch data here
            await fetchTaskData(); // You would define this function to reload your data
          },
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          taskData?['delivery_address'] ?? 'no address',
                          style: TextStyle(
                              fontSize: 20,
                              color: Pallete.mainFontColor,
                              fontWeight: FontWeight.bold),
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
                            onPressed: _isPunchPressed
                                ? null // Disable the button after it has been pressed
                                : () async {
                                    setState(() {
                                      _isPunchPressed =
                                          true; // Set the button to pressed
                                    });

                                    // Call the punchInRepo API
                                    final featureView =
                                        Provider.of<FeatureView>(context,
                                            listen: false);

                                    await featureView
                                        .punchInRepo(visiter_name); // API call
                                    print(visiter_name);

                                    if (featureView.message != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(featureView.message!),
                                      ));
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
                              "Punched in at ${TimeOfDay.now().format(context)}", // Update message
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
                                      .where((entry) => !isSelected[entry.key])
                                      .map((entry) {
                                    int index = entry.key;
                                    var item = entry.value;

                                    bool showProductCode = item['item_code'] !=
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
                                                      List selectedSymptoms =
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
                                                      color:
                                                          Pallete.mainFontColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      List selectedSymptoms =
                                                          getChecktreeForItemCode(
                                                              item['name']);
                                                      print('lolflfqlflqflqfl');
                                                      print(
                                                          getChecktreeForItemCode(
                                                              item['name']));
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          child: AddSymptoms(
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
                                                      Icons.add_circle_rounded,
                                                      color:
                                                          Pallete.mainFontColor,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.location_on,
                                                      color:
                                                          Pallete.mainFontColor,
                                                    ),
                                                    onPressed: () {
                                                      print(item[
                                                          'item_location']);
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Item Location'),
                                                            content: Text(
                                                              item['item_location'] ??
                                                                  'No Item location provided',
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
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
                                                item['item_name'] ?? 'No name',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        CheckboxListTile(
                                          activeColor: Pallete.mainFontColor,
                                          hoverColor: Pallete.mainFontColor,
                                          checkboxShape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          value: isSelected[index],
                                          title: Text(
                                              item['heading'] ?? 'No heading'),
                                          onChanged: (val) async {
                                            setState(() {
                                              isSelected[index] = val ?? false;
                                            });

                                            String name = items[index]['name'];
                                            String status = items[index]
                                                    ['collected'] ??
                                                'no';

                                            await Checktree.updateChecktreeRepo(
                                                name,
                                                work_done: "yes");
                                          },
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
                                    padding: EdgeInsets.symmetric(vertical: 10),
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
                                      .where((entry) => isSelected[entry.key])
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
                                          padding: const EdgeInsets.all(8.0),
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
                                                item['heading'] ?? 'No heading',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    isSelected[index] = false;
                                                  });
                                                  String name =
                                                      items[index]['name'];

                                                  await Checktree
                                                      .updateChecktreeRepo(name,
                                                          work_done: "no");
                                                },
                                                child: const Icon(
                                                  Icons.delete_forever_rounded,
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
                                        width:
                                            100, // Container width for the image
                                        height:
                                            200.0, // Fixed height for the image container
                                        padding: const EdgeInsets.all(
                                            8.0), // Optional padding
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10), // Rounded corners
                                          border: Border.all(
                                              color: Colors
                                                  .grey), // Border around the container
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              10), // Clip image with rounded corners
                                          child: Image.file(
                                            _imageFile!, // Ensure _imageFile is not null before passing
                                            fit: BoxFit
                                                .cover, // Makes the image cover the container area
                                          ),
                                        ),
                                      ),

                                    // Add another icon at the right side of the Row
                                    const Spacer(), // This makes the second icon move to the right end of the Row
                                    IconButton(
                                      icon: const Icon(
                                        Icons
                                            .upload_file, // Example icon, change it as needed
                                        color:
                                            Pallete.iconAddColor, // Icon color
                                      ),
                                      onPressed: () {
                                        _uploadImage(context);
                                        // add post uplaod api here
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
                        // note container
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
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ElevatedButton(
                                    onPressed: () async {
                                      print('fqfqqfq/////');
                                      print('fqfqqfq/////');
                                      String note = noteController.text;

                                      await Checktree.technicianNotes(
                                          visiter_name, note);
                                    },
                                    child: Text('Submit'))
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
                            onPressed: _handlePunchOut,
                            child: Text(
                              _isPunchOutPressed ? 'PUNCHED OUT' : 'PUNCH OUT',
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
        ));
  }
}
