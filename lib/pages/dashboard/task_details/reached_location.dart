import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/drawer.dart';
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
  List<bool> isSelected = [
    false,
    false,
    false,
    false
  ]; // List for checkbox states

  bool _isPunchPressed = false;
  bool _isPunchOutPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appbar
      appBar: CustomAppBar(title: 'Task Details'),
      drawer: DrawerPage(),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Location',
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
                SizedBox(
                  height: 20,
                ),
                // Punch In for Job Button

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
                    onPressed: () {
                      setState(() {
                        _isPunchPressed = !_isPunchPressed;
                      });
                    },
                    child: Text(
                      _isPunchPressed ? 'PUNCHED IN' : 'PUNCH IN FOR THE JOB',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (_isPunchPressed)
                  Positioned(
                    child: Center(
                      child: Container(
                        child: const Text(
                          'Job Punch in Successful! AT 16:00 PM',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Pallete.punchButtonColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
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
                                      builder: (context) => const AddSymptoms(),
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
                            value: isSelected[0],
                            onChanged: (value) {
                              setState(() {
                                isSelected[0] = value!;
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
                            value: isSelected[1],
                            onChanged: (value) {
                              setState(() {
                                isSelected[1] = value!;
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
                            value: isSelected[2],
                            onChanged: (value) {
                              setState(() {
                                isSelected[2] = value!;
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
                            value: isSelected[3],
                            onChanged: (value) {
                              setState(() {
                                isSelected[3] = value!;
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
                    onPressed: () {
                      setState(() {
                        _isPunchOutPressed = !_isPunchOutPressed;
                      });
                    },
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
                  Positioned(
                    child: Center(
                      child: Container(
                        child: const Text(
                          'Job Punch OUT Successful! AT 16:00 PM',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Pallete.redBtnColor,
                          ),
                        ),
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
