import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/dashboard.dart';

class blanktPage extends StatefulWidget {
  const blanktPage({super.key});

  @override
  State<blanktPage> createState() => _blanktPageState();
}

class _blanktPageState extends State<blanktPage> {
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
                  TextSpan(text: 'Request sent to Administrator\n'),
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
