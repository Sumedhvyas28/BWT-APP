import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/add_symptoms.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/look_symptoms.dart';

//pending
// punch in button functionality to be changed

class ReachedLocation extends StatefulWidget {
  const ReachedLocation({super.key});

  @override
  State<ReachedLocation> createState() => _ReachedLocationState();
}

class _ReachedLocationState extends State<ReachedLocation> {
  double _fillWidth = double.infinity;
  bool _isChecked = false;
  bool _isPunchPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: CustomAppBar(title: 'Task Details'),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    width: _fillWidth,
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            // Punch In for Job Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      _isPunchPressed
                          ? Pallete.punchButtonColor
                          : Pallete.activeButtonColor,
                    ),
                  ),
                  onPressed: () {
                    _isPunchPressed = !_isPunchPressed;
                  },
                  child: const Text(
                    'PUNCH IN FOR JOB',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Scrollable List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Product Row
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'PRODUCT 1',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Pallete.mainFontColor,
                                ),
                              ),
                              // Icons
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: Pallete.mainFontColor,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LookForSymptoms(),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.maps_ugc,
                                      color: Pallete.mainFontColor,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddSymptoms(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'This is a description for Product 1.This is a description for Product 1.  ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle_rounded,
                                  color: Pallete.iconAddColor,
                                  size: 30,
                                ),
                                onPressed: () {},
                              ),
                              const Text(
                                'Add attachements',
                                style: TextStyle(
                                  color: Pallete.iconAddColor,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.location_pin,
                                  color: Pallete.iconMapColor,
                                  size: 30,
                                ),
                                onPressed: () {},
                              ),
                              const Text(
                                'Product Location',
                                style: TextStyle(
                                  color: Pallete.iconMapColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    //below this everyting is copy paste of above container

                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'PRODUCT 2',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Pallete.mainFontColor,
                                ),
                              ),
                              // Icons
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: Pallete.mainFontColor,
                                      size: 30,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.maps_ugc,
                                      color: Pallete.mainFontColor,
                                      size: 30,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'This is a description for Product 1.This is a description for Product 1.  ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_rounded,
                                    color: Pallete.iconAddColor,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                                const Text(
                                  'Add attachements',
                                  style: TextStyle(
                                    color: Pallete.iconAddColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.location_pin,
                                    color: Pallete.iconMapColor,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                                const Text(
                                  'Product Location',
                                  style: TextStyle(
                                    color: Pallete.iconMapColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'This is a description for Product 1.This is a description for Product 1.  ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_rounded,
                                    color: Pallete.iconAddColor,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                                const Text(
                                  'Add attachements',
                                  style: TextStyle(
                                    color: Pallete.iconAddColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.location_pin,
                                    color: Pallete.iconMapColor,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                                const Text(
                                  'Product Location',
                                  style: TextStyle(
                                    color: Pallete.iconMapColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //3rd
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'PRODUCT 3',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Pallete.mainFontColor,
                                ),
                              ),
                              // Icons
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.search,
                                      color: Pallete.mainFontColor,
                                      size: 30,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.maps_ugc,
                                      color: Pallete.mainFontColor,
                                      size: 30,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                },
                              ),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'This is a description for Product 1.This is a description for Product 1.  ',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle_rounded,
                                    color: Pallete.iconAddColor,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                                const Text(
                                  'Add attachements',
                                  style: TextStyle(
                                    color: Pallete.iconAddColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.location_pin,
                                    color: Pallete.iconMapColor,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                                const Text(
                                  'Product Location',
                                  style: TextStyle(
                                    color: Pallete.iconMapColor,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    // attachment card
                    Container(
                      child: const Card(
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Attachment for the Task Completion',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.add_circle_rounded,
                                    color: Pallete.iconAddColor,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Add Attachment',
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
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // note container
                    Container(
                      child: Card(
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

                    const SizedBox(
                      height: 30,
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Pallete.punchOutBtn)),
                      child: const Text(
                        'Punch Out',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    if (_isPunchPressed)
                      const Text(
                        'Job Punch In Successful!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Pallete.mainFontColor,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
