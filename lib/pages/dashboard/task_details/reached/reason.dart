import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/dashboard.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/blank.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';

class ReasonPage extends StatefulWidget {
  const ReasonPage({super.key});

  @override
  State<ReasonPage> createState() => _ReasonPageState();
}

class _ReasonPageState extends State<ReasonPage> {
  // Dropdown value state
  String? _selectedReason;

  // TextEditingController for the detailed reason and working hours
  final TextEditingController _detailedReasonController =
      TextEditingController();
  final TextEditingController _workingHoursController = TextEditingController();

  // List of options for the dropdown
  final List<String> _reasons = [
    'Personal reasons',
    'Client request',
    'System issues',
    'Weather conditions',
    'others'
  ];

  // DateTime state for the rescheduled date
  DateTime? _selectedDate;

  // State for button pressed
  bool _isButtonPressed = false;
  String _buttonText = 'SUBMIT FOR APPROVAL'; // Default button text
  Color _buttonColor = Pallete.activeButtonColor; // Default button color
  String _isPunchOutMessage = ''; // Message to display when button is pressed

  // Function to handle button press
// Function to handle button press
  void _onButtonPressed() {
    // Validate all fields before proceeding
    if (_selectedReason == null ||
        _detailedReasonController.text.isEmpty ||
        _selectedDate == null ||
        _workingHoursController.text.isEmpty) {
      // Show an alert if validation fails
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Validation Error'),
            content: Text('Please fill all fields before submitting.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      _buttonColor = Pallete.disabledBtnColor; // Change button background color
      _buttonText = 'RESCHEDULED'; // Change button text
      _isButtonPressed = true; // Mark button as pressed
      _isPunchOutMessage =
          "Punched out at ${TimeOfDay.now().format(context)}"; // Update message

      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
          context,
          PageTransition(
            child: blanktPage(),
            type: PageTransitionType.fade,
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _detailedReasonController.dispose(); // Dispose the controller
    _workingHoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomDashApp(title: 'Task Reschedule'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Reason Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),

              // DropdownButtonFormField for selecting the reason
              DropdownButtonFormField<String>(
                value: _selectedReason,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                ),
                hint: const Text('Select Your Reason'),
                items: _reasons.map((String reason) {
                  return DropdownMenuItem<String>(
                    value: reason,
                    child: Text(reason),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedReason = newValue;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Add Your Reason (Detailed Reason)
              const Text(
                'Add Your Detailed Reason',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),

              // TextField for detailed reason
              TextField(
                controller: _detailedReasonController,
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Type your reason here...',
                ),
              ),
              const SizedBox(height: 20),

              // Reschedule Date
              const Text(
                'Proposed Reschedule Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? 'Select Date'
                        : 'Selected date: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Working hours field
              const Text(
                'Additional Hours Needed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),

              // TextField for working hours
              TextField(
                controller: _workingHoursController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  hintText: 'Enter working hours',
                ),
              ),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.all(2),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed:
                        _onButtonPressed, // Call the button press function

                    child: Text(
                      _buttonText,
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),

              // Display the message below the button if pressed
              if (_isButtonPressed)
                Center(
                  child: Text(
                    _isPunchOutMessage,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Pallete.redBtnColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to pick date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now, // Prevent selecting dates before today
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
