import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';

class Error2Page extends StatelessWidget {
  const Error2Page({super.key});

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
                  },
                  child: Text(
                    'Close',
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
              'ERROR',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          )),
          Divider(thickness: 2, color: Colors.black), // Divider under title
        ],
      ),
      contentPadding: EdgeInsets.all(13),
      content: Text(
        'Please Attach an Image',
        maxLines: 4,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontSize: 18,
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
    );
  }
}
