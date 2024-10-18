import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/submit.dart';

class ReasonPage extends StatefulWidget {
  const ReasonPage({super.key});

  @override
  State<ReasonPage> createState() => _ReasonPageState();
}

class _ReasonPageState extends State<ReasonPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actions: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Pallete.activeButtonColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Submit For Approval',
                style: TextStyle(color: Colors.white, fontSize: 23),
                maxLines: 2,
              ),
            ),
          ),
        )
      ],
      title: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
              child: Text(
                'REASON OF RESCHEDULING',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
              labelText: 'Select Your reason',
              labelStyle: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SubmitPage();
                  });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  color: Pallete.termsFontColor,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Add your reason',
                  style: TextStyle(color: Pallete.termsFontColor),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
              labelText: 'Date Of Reschedule',
              labelStyle: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
              labelText: 'Working Hours',
              labelStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
