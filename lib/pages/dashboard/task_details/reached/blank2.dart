import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/dashboard.dart';

class blankNewPage extends StatefulWidget {
  const blankNewPage({super.key});

  @override
  State<blankNewPage> createState() => _blankNewPageState();
}

class _blankNewPageState extends State<blankNewPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate loading for a few seconds before redirecting
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
      // Navigate to Dashboard after loading
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomDashApp(title: 'Reschedule'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 30),
                children: <TextSpan>[
                  TextSpan(text: 'Successfully punched out\n'),
                  TextSpan(text: 'Redirecting to dashboard\n'),
                ],
              ),
            ),
            // Loader at the bottom
            if (isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(
                  color: Pallete.mainFontColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
