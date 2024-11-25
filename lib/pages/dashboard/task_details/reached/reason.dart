import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/blank.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class ReasonPage extends StatefulWidget {
  final String name; // Add a name parameter

  const ReasonPage({super.key, required this.name});

  @override
  State<ReasonPage> createState() => _ReasonPageState();
}

class _ReasonPageState extends State<ReasonPage> {
  String? _selectedReason;
  final TextEditingController _detailedReasonController =
      TextEditingController();
  final TextEditingController _workingHoursController = TextEditingController();
  final List<String> _reasons = [
    'Personal reasons',
    'Client request',
    'System issues',
    'Weather conditions',
    'others'
  ];
  DateTime? _selectedDate;

  bool _isButtonPressed = false;
  String _buttonText = 'SUBMIT FOR APPROVAL';
  Color _buttonColor = Pallete.activeButtonColor;
  String _isPunchOutMessage = '';
  late String mainName;

  @override
  void initState() {
    mainName = widget.name;

    super.initState();
  }

  void _onButtonPressed() async {
    if (_selectedReason == null ||
        _detailedReasonController.text.isEmpty ||
        _selectedDate == null ||
        _workingHoursController.text.isEmpty) {
      // Show an alert if validation fails
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please fill all fields before submitting.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
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

    // Call the ViewModel's submitTaskReschedule method
    final viewModel = Provider.of<FeatureView>(context, listen: false);
    await viewModel.submitTaskReschedule(
      maintenanceVisit: mainName,
      type: _selectedReason!,
      reason: _detailedReasonController.text,
      date: _selectedDate!.toLocal().toString().split(' ')[0],
      hours: _workingHoursController.text,
    );
    print(mainName);
    print('Selected reason: $_selectedReason');
    print('Detailed reason: ${_detailedReasonController.text}');
    print('Date: $_selectedDate');
    print('Hours: ${_workingHoursController.text}');

    // Update UI based on result
    setState(() {
      _buttonColor = Pallete.disabledBtnColor;
      _buttonText = 'RESCHEDULED';
      _isButtonPressed = true;
      _isPunchOutMessage = "Punched out at ${TimeOfDay.now().format(context)}";
    });

    // Navigate after a delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        PageTransition(
          child: blanktPage(),
          type: PageTransitionType.fade,
        ),
      );
    });
  }

  @override
  void dispose() {
    _detailedReasonController.dispose();
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
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedReason,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
              const Text(
                'Add Your Detailed Reason',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailedReasonController,
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Type your reason here...',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Proposed Reschedule Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
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
              const Text(
                'Additional Hours Needed',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _workingHoursController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Enter working hours',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _onButtonPressed,
                  child: Text(
                    _buttonText,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              if (_isButtonPressed)
                Center(
                  child: Text(
                    _isPunchOutMessage,
                    style: const TextStyle(
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
