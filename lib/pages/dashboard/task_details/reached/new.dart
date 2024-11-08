import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/models/product_list.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/add_symptoms.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/look_symptoms.dart';
import 'package:page_transition/page_transition.dart';

class ReachedLocationT extends StatefulWidget {
  const ReachedLocationT({super.key});

  @override
  State<ReachedLocationT> createState() => _ReachedLocationTState();
}

class _ReachedLocationTState extends State<ReachedLocationT> {
  bool _isPunchPressed = false;
  bool isRescheduled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Task Details',
      ),
      body: Column(
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

          // Expanded ListView.builder
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context, productList[index], index);
              },
            ),
          ),

          // Button below the list
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }

  Widget _buildProductCard(
      BuildContext context, Map<String, dynamic> product, int index) {
    return Container(
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
                product['name'],
                style: const TextStyle(
                  fontSize: 20,
                  color: Pallete.mainFontColor,
                ),
              ),
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
                        PageTransition(
                          child: LookForSymptoms(),
                          type: PageTransitionType.fade,
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
                        PageTransition(
                          child: AddSymptoms(),
                          type: PageTransitionType.fade,
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
                value: productList[index]['isSelected'],
                onChanged: (value) {
                  setState(() {
                    productList[index]['isSelected'] = value!;
                  });
                },
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  product['description'],
                  style: const TextStyle(fontSize: 16),
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
                onPressed: () {
                  // Handle add attachments functionality
                },
              ),
              const Text(
                'Add attachments',
                style: TextStyle(
                  color: Pallete.iconAddColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                icon: const Icon(
                  Icons.location_pin,
                  color: Pallete.iconMapColor,
                  size: 30,
                ),
                onPressed: () {
                  // Handle location functionality
                },
              ),
              const Text(
                'Product Location',
                style: TextStyle(
                  fontSize: 12,
                  color: Pallete.iconMapColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



// / new 





// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/constants/custom_dashapp.dart';

// class Newo extends StatefulWidget {
//   const Newo({super.key, this.task});
//   final Map<String, dynamic>? task;

//   @override
//   State<Newo> createState() => _NewoState();
// }

// class _NewoState extends State<Newo> {
//   Map<String, dynamic>? taskData;
//   bool isLoading = true;

//   List<bool> isSelected = [];

//   @override
//   void initState() {
//     super.initState();
//     taskData = widget.task;
//     isLoading = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     final task = taskData;
//     final checktreeDescription = task?['checktree_description'] ?? {};

//     // Flatten the nested structure
//     List<Map<String, dynamic>> items = [];
//     checktreeDescription.forEach((key, value) {
//       if (value is List) {
//         items.addAll(List<Map<String, dynamic>>.from(value));
//       }
//     });

//     // Ensure isSelected matches the number of items
//     if (isSelected.length != items.length) {
//       isSelected = List<bool>.filled(items.length, false);
//     }

//     String? lastDisplayedProductCode;

//     return Scaffold(
//       appBar: CustomDashApp(title: 'Product List'),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: EdgeInsets.all(8),
//         child: Column(
//           children: [
//             Text(
//               'Product List',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 10),
//             Divider(color: Colors.green, thickness: 4),
//             SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: items.length,
//                 itemBuilder: (context, index) {
//                   final item = items[index];
//                   final itemCode = item['item_code'] ?? 'No Item Code';
//                   final itemName = item['item_name'] ?? 'No Item Name';
//                   final heading = item['heading'] ?? 'no heading';

//                   bool showProductCode = itemCode != lastDisplayedProductCode;
//                   if (showProductCode) {
//                     lastDisplayedProductCode = itemCode;
//                   }

//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       if (showProductCode) ...[
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     itemCode,
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   Spacer(),
//                                   Icon(Icons.ac_unit),
//                                   Icon(Icons.ac_unit),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 6,
//                               ),
//                               Text(
//                                 itemName,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                       ],
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: isSelected[index],
//                             onChanged: (bool? newBool) {
//                               setState(() {
//                                 isSelected[index] = newBool ?? false;

//                                 // Move item based on checkbox state
//                                 if (newBool!) {
//                                   final itemToMove = items.removeAt(index);
//                                   items.add(itemToMove);
//                                 } else {
//                                   final itemToMove =
//                                       items.removeAt(items.length - 1);
//                                   items.insert(index, itemToMove);
//                                 }
//                               });
//                             },
//                           ),
//                           Expanded(
//                             child: Text(
//                               heading,
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
