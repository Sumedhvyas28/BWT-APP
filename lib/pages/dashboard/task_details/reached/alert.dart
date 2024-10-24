import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/reason.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      actions: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Pallete.activeButtonColor),
                  onPressed: () {
                    Navigator.of(context).pop();

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ReasonPage()));

                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return const ReasonPage();
                    //     });
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Pallete.redBtnColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      title: Column(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Text(
              'ATTENTION',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          )),
          Divider(thickness: 2, color: Colors.black), // Divider under title
        ],
      ),
      contentPadding: EdgeInsets.all(13),
      content: Text(
        'Your assigned Task is not complete. Do you want to reschedule the visit?',
        maxLines: 4,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
    );
  }
}
