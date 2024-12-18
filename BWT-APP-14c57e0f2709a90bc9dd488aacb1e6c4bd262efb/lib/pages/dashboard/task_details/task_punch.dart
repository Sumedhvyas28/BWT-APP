import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/newO.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/reached_location.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart'; // Add this import for Lottie animations

class TaskPunch extends StatefulWidget {
  final Map<String, dynamic>? task;

  const TaskPunch({super.key, this.task});

  @override
  State<TaskPunch> createState() => TaskPunchState();
}

class TaskPunchState extends State<TaskPunch> {
  Map<String, dynamic>? taskData;
  bool isLoading = true;

  Color _buttonColor = const Color.fromARGB(173, 149, 149, 143); // before delay
  double _fillWidth = 0;
  final double _containerWidth = 350;
  bool _showLocations = false;
  bool _showDistance = false;
  late double lat;
  late double long;
  String locationMessage = 'current location';

  @override
  void initState() {
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        taskData = widget.task;
        isLoading = false;
        _newTask();
        _buttonColor = Pallete.activeButtonColor;
        _fillWidth = _containerWidth * 0.7;
        _showLocations = true;
        _showDistance = true;
      });
    });
    super.initState();
  }

  Future<Map<String, double>> _getCurrentLocation(
      {double? lat1, double? lon1}) async {
    if (lat1 != null && lon1 != null) {
      print("Using provided lat1: $lat1, lon1: $lon1");
      return {'latitude': lat1, 'longitude': lon1};
    } else {
      // If lat1 and lon1 are not provided, check location services and permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        // Show a dialog or a message asking the user to enable location services
        _showLocationServiceDialog();
        return Future.error('Location services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permission is denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permission');
      }

      // Get current location if all permissions and services are okay
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Only return latitude and longitude as a map
      return {'latitude': position.latitude, 'longitude': position.longitude};
    }
  }

  void _newTask() async {
    try {
      // Check if taskData is available
      if (taskData == null) {
        print("Task data is null.");
        return;
      }

      // Safe access to 'geolocation'
      final geolocation = taskData?['geolocation'];
      if (geolocation == null) {
        print("Geolocation data is missing.");
        return;
      }

      final features = geolocation['features'] as List<dynamic>?;
      if (features == null || features.isEmpty) {
        print("Features data is missing.");
        return;
      }

      final geometry = features[0]['geometry'] as Map<String, dynamic>?;
      if (geometry == null || geometry['coordinates'] == null) {
        print("Geometry data or coordinates are missing.");
        return;
      }

      // Extract coordinates with safe access
      final coordinates = geometry['coordinates'] as List<dynamic>?;
      if (coordinates == null || coordinates.length < 2) {
        print("Invalid coordinates.");
        return;
      }
// Extract coordinates as double
      final lat1 = coordinates[1] as double;
      final lon1 = coordinates[0] as double;

      print('Coordinates fetched: lat1: $lat1, lon1: $lon1');

      // Fetch the current location for lat2 and lon2
      Map<String, double> currentLocation = await _getCurrentLocation();
      double lat2 = currentLocation['latitude']!;
      double lon2 = currentLocation['longitude']!;

      print('Current Location: lat2: $lat2, lon2: $lon2');

      // Call the postLocationDistance API
      // await FeatureView.postLocationDistance(lat1, lon1, lat2, lon2);

      // Show distance result (update UI with this)
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Distance Calculation"),
            content: Text('New task completed.'),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error in fetching distance: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text("An error occurred: $e"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

// Function to show the alert dialog
  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Location Services Disabled"),
          content: Text(
              "Please enable location services to get your current location."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Geolocator.openLocationSettings(); // Opens location settings
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Open Settings"),
            ),
          ],
        );
      },
    );
  }

  void _performAction() {
    // Your action here (e.g., make an API call, navigate to a new screen, etc.)
    print('Action performed!');
  }

  @override
  Widget build(BuildContext context) {
    print(taskData);
    if (taskData == null) {
      print("Task data is not available yet.");
      return const CircularProgressIndicator();
    }
    print(taskData ?? "");
    final geolocation = taskData?['geolocation'];
    if (geolocation == null) {
      print("Geolocation data is not available.");
      return const Text("Geolocation data missing");
    }

    final features = geolocation['features'] as List<dynamic>?;
    if (features == null || features.isEmpty) {
      print("Features data is missing.");
      return const Text("Features data missing");
    }

    final geometry = features[0]['geometry'] as Map<String, dynamic>?;
    if (geometry == null || geometry['coordinates'] == null) {
      print("Geometry data is missing.");
      return const Text("Geometry data missing");
    }

    // Extract coordinates
    final coordinates = geometry['coordinates'] as List<dynamic>;
    final lon1 = coordinates[0];
    final lat1 = coordinates[1];

    _getCurrentLocation().then((value) {
      lat = value['latitude']!; // Use the key to get latitude
      long = value['longitude']!; // Use the key to get longitude
    });

    // print('Latitude 1: $lat1, Longitude 1: $lon1');
    // print('Latitude 2: $lat, Longitude 2: $long');

    if (widget.task == null) {
      throw Exception('failed to load data');
    }

    return Scaffold(
      appBar: CustomDashApp(title: 'Task Details'),
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskData?['delivery_addres'] ?? 'no address',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: _fillWidth,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Pallete.mainFontColor,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    if (_showDistance)
                      Positioned(
                        left: _fillWidth - 35,
                        top: 25,
                        child: Text(
                          '300m',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Show locations after delay below the rectangle
              if (_showLocations)
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Start location',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(Factory)',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'End location',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(Client Location)',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              const SizedBox(
                height: 60,
              ),

              Container(
                width: double.infinity,
                height: 100,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      // _newTask();
                      // Navigator.push(
                      //     context,
                      //     PageTransition(
                      //       child: Newo(
                      //         // task: taskData,
                      //       ),
                      //       type: PageTransitionType.fade,
                      //     ));
                    },
                    child: Text(
                      'Reached to location',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Lottie.asset(
                  'assets/animations/1.json',
                  height: 300,
                  width: 300,
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
