import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/models/symptom.dart';
import 'package:flutter_application_1/view_model/checktree.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddSymptoms extends StatefulWidget {
  const AddSymptoms({super.key, this.task});
  final List<dynamic>? task;

  @override
  State<AddSymptoms> createState() => _AddSymptomsState();
}

class _AddSymptomsState extends State<AddSymptoms> {
  List<SymptomData> symptomsB = []; // List to hold each symptom's data
  bool isLoading = true;
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  List<dynamic>? taskData;
  late List tak;

  Future<void> _takePicture(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final name = DateTime.now().millisecondsSinceEpoch.toString();
      final imagePath = '${directory.path}/$name.jpg';

      final File storedImage = await File(image.path).copy(imagePath);

      setState(() {
        // Add the image to the corresponding index in the symptoms list
        symptomsB[index].image = storedImage;
      });

      print("Image saved at: ${storedImage.path}");
    } else {
      print("No image selected.");
    }
  }

  void _addNewSymptomSection() async {
    setState(() {
      // Add a new empty SymptomData to the list with default values
      symptomsB.add(SymptomData(symptom: '', solution: '', image: null));
    });
  }

  Future<void> _uploadImage() async {
    for (var symptomData in symptomsB) {
      if (symptomData.image != null) {
        try {
          final imageBytes = await symptomData.image!.readAsBytes();

          final uri = Uri.parse(
              "https://5a9d-45-113-107-90.ngrok-free.app/api/method/field_service_management.api.add_symptom_requests");
          final request = http.MultipartRequest("POST", uri)
            ..files.add(http.MultipartFile.fromBytes(
              'image',
              imageBytes,
              filename: "symptom_image.jpg",
            ))
            ..fields['symptom'] = symptomData.symptom
            ..fields['solution'] = symptomData.solution;

          final maintenanceVisit = taskData?.first['maintenance_visit'] ??
              'MAT-MVS-2024-00002'; // Default if null
          final itemCode =
              taskData?.first['item_code'] ?? ''; // Default if null

          request.fields['maintenance_visit'] = maintenanceVisit;
          request.fields['item_code'] = itemCode;

          final response = await request.send();

          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image uploaded successfully')),
            );
          } else {
            final responseBody = await response.stream.bytesToString();
            print("Failed: ${response.statusCode}, $responseBody");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to upload image: $responseBody')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      }
    }
  }

  @override
  void initState() {
    taskData = widget.task;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('/////////');
    print(taskData);

    List<String> parentList = [];
    List<String> itemList = [];

    if (taskData != null) {
      for (var task in taskData!) {
        // Each task is a map, and you can access the 'parent' key directly
        if (task['parent'] != null) {
          parentList.add(task['parent']);
        }
        if (task['item_code'] != null) {
          itemList.add(task['item_code']);
        }
      }
    }

    print('Parent List: $parentList');
    print('item List: $itemList');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomDashApp(title: 'Symptoms'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Text(
                    'ADD NEW SYMPTOMS',
                    style: TextStyle(
                        color: Pallete.mainFontColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    '  -  Product 1',
                    style: TextStyle(color: Pallete.mainFontColor),
                  ),
                ],
              ),
            ),
            // Dynamically create symptom sections based on the list
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: symptomsB.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    elevation: 3,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Symptoms ${index + 1}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: TextEditingController(
                                text: symptomsB[index].symptom),
                            onChanged: (text) {
                              symptomsB[index].symptom =
                                  text; // Update the symptom in the list
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter symptom...',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: TextEditingController(
                                text: symptomsB[index].solution),
                            onChanged: (text) {
                              symptomsB[index].solution =
                                  text; // Update the solution in the list
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter solution...',
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await _takePicture(
                                      index); // Trigger camera for current index
                                },
                                child: const Icon(Icons.attach_file,
                                    color: Pallete.iconAddColor),
                              ),
                              SizedBox(width: 5),
                              const Text(
                                'Add attachment',
                                style: TextStyle(
                                  color: Pallete.iconAddColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Pallete.mainFontColor,
                size: 35,
              ),
              onPressed: _addNewSymptomSection,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await Checktree.addSymptomsRequest(
                        parentList.join(
                            ', '), // Convert list to a comma-separated string for parent
                        itemList.join(', '),
                        context, // Convert list to a comma-separated string for item
                        symptomsData:
                            symptomsB // Pass symptoms data as a named argument
                        );
                  },
                  child: const Text(
                    'REQUEST FOR APPROVAL',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Pallete.mainFontColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
