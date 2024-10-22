import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/drawer.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/models/product_list.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/add_symptoms.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/alert.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/error_page.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/look_symptoms.dart';
import 'package:page_transition/page_transition.dart';

//pending
// punch in button functionality to be changed

class ReachedLocation extends StatefulWidget {
  const ReachedLocation({super.key});

  @override
  State<ReachedLocation> createState() => _ReachedLocationState();
}

class _ReachedLocationState extends State<ReachedLocation> {
  bool _isPunchPressed = false;
  bool _isPunchOutPressed = false;
  bool isRescheduled = false;
  String _isPunchOutMessage = '';
  List<Map<String, dynamic>> removedDescriptions = [];

  List<Map<String, dynamic>> removedProducts = []; // List for removed products

  void _handlePunchOut() {
    // Extracting the selection condition
    var selectionStatus = checkDescriptionSelections(productList);

    bool allSelected = selectionStatus['allSelected']!;
    bool anyDescriptionNotSelected =
        selectionStatus['anyDescriptionNotSelected']!;

    print('anyDescriptionNotSelected: $anyDescriptionNotSelected');
    print('allSelected: $allSelected');

    if (allSelected && _isPunchPressed) {
      setState(() {
        _isPunchOutPressed = true;
        _isPunchOutMessage = 'Job Punch OUT Successful! AT 16:00 PM';
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          if (!_isPunchPressed) {
            return ErrorPage();
          } else
            return AlertPage();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      //appbar
      appBar: CustomDashApp(title: 'Task Details'),
      drawer: DrawerPage(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                Center(
                  child: const Text(
                    'Job Punch in Successful! AT 16:00 PM',
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
              // Product Row
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics:
                          const AlwaysScrollableScrollPhysics(), // Allow scrolling
                      itemCount:
                          productList.length + removedDescriptions.length,
                      itemBuilder: (context, index) {
                        if (index < productList.length) {
                          return _buildProductCard(
                              context, productList[index], index);
                        } else {
                          int removedIndex = index - productList.length;
                          return _buildRemovedDescriptionCard(
                              context, removedDescriptions[removedIndex]);
                        }
                      },
                    ),
                  ),
                ],
              ),

              const Card(
                color: Colors.white,
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
    );
  }

  Widget _buildProductCard(
      BuildContext context, Map<String, dynamic> product, int index) {
    // Hide the product card if there are no descriptions left
    if (product['description'].isEmpty) {
      return const SizedBox.shrink();
    }

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['name'] ?? 'Unknown Product',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: LookForSymptoms(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.search,
                        color: Pallete.mainFontColor,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: AddSymptoms(),
                            type: PageTransitionType.fade,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.maps_ugc,
                        color: Pallete.mainFontColor,
                        size: 30,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 5),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: product['description'].length,
              itemBuilder: (context, descIndex) {
                return Row(
                  children: [
                    Checkbox(
                      value: product['descriptionSelections'][descIndex],
                      onChanged: (value) {
                        setState(() {
                          product['descriptionSelections'][descIndex] = value!;

                          // Move description to removed list if checked
                          if (value) {
                            removedDescriptions.add({
                              'productName': product['name'],
                              'description': product['description'][descIndex],
                              'productIndex': index,
                              'descIndex': descIndex,
                            });

                            // Remove description from the original product
                            product['description'].removeAt(descIndex);
                            product['descriptionSelections']
                                .removeAt(descIndex);
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        product['description'][descIndex],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRemovedDescriptionCard(
      BuildContext context, Map<String, dynamic> removedItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {
                  setState(() {
                    int productIndex = removedItem['productIndex'];

                    productList[productIndex]['description'].insert(
                        removedItem['descIndex'], removedItem['description']);
                    productList[productIndex]['descriptionSelections']
                        .insert(removedItem['descIndex'], false);

                    // Remove from the removed descriptions list
                    removedDescriptions.remove(removedItem);
                  });
                },
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "${removedItem['productName']} - ${removedItem['description']}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Pallete.mainFontColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
