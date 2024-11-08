import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';

class Elevatedbutton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPressed;

  const Elevatedbutton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 300,
        decoration: BoxDecoration(
          color: Pallete.punchButtonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
