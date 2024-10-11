import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/pallete.dart';

// pending
// product  wise no should updated

class AddSymptoms extends StatefulWidget {
  const AddSymptoms({super.key});

  @override
  State<AddSymptoms> createState() => _AddSymptomsState();
}

class _AddSymptomsState extends State<AddSymptoms> {
  List<Widget> symptomSections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Task Details'),
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
            Column(
              children: symptomSections,
            ),
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Pallete.mainFontColor,
                size: 35,
              ),
              onPressed: _addNewSymptomSection,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.mainFontColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'REQUEST FOR APPROVAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to add a new symptom section
  void _addNewSymptomSection() {
    setState(() {
      symptomSections.add(
        Padding(
          padding: const EdgeInsets.all(8),
          child: Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Symptoms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const TextField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Icon(Icons.attach_file, color: Pallete.iconAddColor),
                      SizedBox(width: 5),
                      Text(
                        'Add attachments',
                        style: TextStyle(color: Pallete.iconAddColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Solution',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const TextField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
