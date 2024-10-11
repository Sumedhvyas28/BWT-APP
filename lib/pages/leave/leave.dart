import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/drawer.dart';
import 'package:flutter_application_1/constants/pallete.dart';

class LeavePage extends StatefulWidget {
  const LeavePage({super.key});

  @override
  State<LeavePage> createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Leave'),
      drawer: DrawerPage(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), // Responsive spacing
            Expanded(
              child: ListView(
                children: [
                  _buildLeaveCard(
                    color: Pallete.leaveBtn1,
                    date: '22 September, 2024',
                    status: 'Complete',
                    buttonText: 'Complete',
                  ),
                  _buildLeaveCard(
                    color: Pallete.leaveBtn2,
                    date: '28 September, 2024',
                    status: 'Approved',
                    buttonText: 'Approved',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveCard({
    required Color color,
    required String date,
    required String status,
    required String buttonText,
  }) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(
          MediaQuery.of(context).size.width * 0.05), // Responsive margin
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(
              MediaQuery.of(context).size.width * 0.03), // Responsive padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: color,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.01), // Responsive spacing
                  Text(
                    date,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width *
                            0.045), // Responsive font size
                  ),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.01), // Responsive spacing
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.05), // Responsive spacing
                  Icon(
                    Icons.pending_sharp,
                    color: color,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.01), // Responsive spacing
                  Text(
                    'Status',
                    style: TextStyle(
                        color: color,
                        fontSize: MediaQuery.of(context).size.width *
                            0.045), // Responsive font size
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.02), // Responsive spacing
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width *
                            0.05, // Responsive padding
                        vertical: MediaQuery.of(context).size.height *
                            0.01, // Responsive padding
                      ),
                      minimumSize: const Size(40, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width *
                            0.035, // Responsive font size
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.01), // Responsive spacing
              // Text field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey),
                ),
                child: const TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.05), // Responsive spacing
            ],
          ),
        ),
      ),
    );
  }
}
