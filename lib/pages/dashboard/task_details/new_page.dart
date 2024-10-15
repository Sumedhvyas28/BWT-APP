// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/constants/custom_appbar.dart';
// import 'package:flutter_application_1/constants/drawer.dart';
// import 'package:flutter_application_1/constants/pallete.dart';
// import 'package:flutter_application_1/pages/dashboard/task_details/add_symptoms.dart';
// import 'package:flutter_application_1/pages/dashboard/task_details/look_symptoms.dart';

// class NewPage extends StatefulWidget {
//   const NewPage({super.key});

//   @override
//   State<NewPage> createState() => _NewPageState();
// }

// class _NewPageState extends State<NewPage> {
//   List<bool> isSelected = [false, false, false, false];
//   bool _isPunchPressed = false;
//   bool _isPunchOutPressed = false;
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: 'Task Details',
//       ),
//       drawer: DrawerPage(),
//       body: Padding(
//         padding: EdgeInsets.all(8),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 'Location',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Pallete.mainFontColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 20,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.grey),
//                 ),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 20,
//                       decoration: BoxDecoration(
//                         color: Pallete.mainFontColor,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 5),
//               const Center(
//                 child: Text(
//                   'Location Reached',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               // Center(
//               //   child: ElevatedButton(
//               //     style: ElevatedButton.styleFrom(
//               //       backgroundColor: _isPunchPressed
//               //           ? Pallete.punchButtonColor
//               //           : Pallete.activeButtonColor,
//               //       shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(12),
//               //       ),
//               //     ),
//               //     onPressed: () {
//               //       setState(() {
//               //         _isPunchPressed = !_isPunchPressed;
//               //       });
//               //     },
//               //     child: Text(
//               //       _isPunchPressed ? 'PUNCHED IN' : 'PUNCH IN FOR THE JOB',
//               //       style: const TextStyle(
//               //         color: Colors.white,
//               //         fontSize: 25,
//               //         fontWeight: FontWeight.bold,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 10,
//               ),
//               // Product Row
//               Container(
//                 margin: const EdgeInsets.only(bottom: 10),
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                       color: const Color.fromARGB(255, 255, 255, 255)
//                           .withOpacity(0.5)),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'PRODUCT 1',
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Pallete.mainFontColor,
//                           ),
//                         ),
//                         // Icons
//                         Row(
//                           children: [
//                             IconButton(
//                               icon: const Icon(
//                                 Icons.search,
//                                 color: Pallete.mainFontColor,
//                                 size: 30,
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         const LookForSymptoms(),
//                                   ),
//                                 );
//                               },
//                             ),
//                             IconButton(
//                               icon: const Icon(
//                                 Icons.maps_ugc,
//                                 color: Pallete.mainFontColor,
//                                 size: 30,
//                               ),
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const AddSymptoms(),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: isSelected[0],
//                           onChanged: (value) {
//                             setState(() {
//                               isSelected[0] = value!;
//                             });
//                           },
//                         ),
//                         const SizedBox(width: 10),
//                         const Expanded(
//                           child: Text(
//                             'This is a description for Product 1.This is a description for Product 1.  ',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         IconButton(
//                           icon: const Icon(
//                             Icons.add_circle_rounded,
//                             color: Pallete.iconAddColor,
//                             size: 30,
//                           ),
//                           onPressed: () {},
//                         ),
//                         const Text(
//                           'Add attachements',
//                           style: TextStyle(
//                             color: Pallete.iconAddColor,
//                             fontSize: 12,
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.location_pin,
//                             color: Pallete.iconMapColor,
//                             size: 30,
//                           ),
//                           onPressed: () {},
//                         ),
//                         const Text(
//                           'Product Location',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Pallete.iconMapColor,
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),

//               // dddd
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
