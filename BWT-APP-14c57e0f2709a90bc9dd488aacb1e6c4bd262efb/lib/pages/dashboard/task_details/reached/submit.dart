import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';

class SubmitPage extends StatefulWidget {
  const SubmitPage({super.key});

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
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
                'Submit For Reason',
                style: TextStyle(color: Colors.white, fontSize: 23),
                maxLines: 2,
              ),
            ),
          ),
        )
      ],
      title: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
          child: Text(
            'REASON',
            maxLines: 2,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
              labelStyle: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
