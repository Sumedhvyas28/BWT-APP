import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/custom_dashapp.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/models/post_location.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/reached/newO.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class NewMapPage extends StatefulWidget {
  final Map<String, dynamic>? task;

  const NewMapPage({super.key, this.task});

  @override
  State<NewMapPage> createState() => _NewMapPageState();
}

class _NewMapPageState extends State<NewMapPage> {
  Map<String, dynamic>? taskData;
  Color buttonColor = Colors.grey; // Default color
  bool isLoading = false; // To track loading state
  double _fillWidth = 0;
  final double _containerWidth = 350;
  bool _showLocations = false;
  bool _showDistance = false;
  late double lat;
  late double long;
  String locationMessage = 'current location';
  bool isMessageTrue = false; // Default to false

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        taskData = widget.task;
      });
    });

    // Directly call the API here (not within postFrameCallback)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await callApi();
    });
  }

  Future<Map<String, double>> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog();
      print('Location services are disabled');
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return {'latitude': position.latitude, 'longitude': position.longitude};
  }

  Future<void> callApi() async {
    final postLData = context.read<FeatureView>();

    try {
      setState(() {
        isLoading = true; // Show loading indicator
      });

      // Fetch current location
      final currentLocation = await _getCurrentLocation();
      final lat2 = currentLocation['latitude']!;
      final lon2 = currentLocation['longitude']!;

      // final lat1 = widget.task?['geolocation']['features'][0]['geometry']
      //     ['coordinates'][1];
      final lat1 = 37.4219983;
      final lon1 = -122.084;
      // final lon1 = widget.task?['geolocation']['features'][0]['geometry']
      //     ['coordinates'][0];

      await postLData.postLocationDataApi(lat1, lon1, lat2, lon2);

      setState(() {
        if (postLData.postLocationData != null &&
            postLData.postLocationData!.message != null) {
          // Check if message is true, set button color and update flags
          bool messageStatus =
              postLData.postLocationData!.message?.message == true;
          buttonColor = messageStatus ? Colors.green : Colors.grey;
          isMessageTrue = messageStatus; // Set the new flag

          // If message is true, show locations and distance
          if (messageStatus) {
            _showLocations = true;
            _showDistance = true;
            _fillWidth = _containerWidth * 0.7;
          } else {
            _showLocations = false;
            _showDistance = false;
          }

          print('Message status: $isMessageTrue');
          print('API message: ${postLData.postLocationData!.message?.message}');
        } else {
          buttonColor = Colors.grey; // Default color in case of an error
          isMessageTrue = false; // Set the flag to false if there's an error
          _showLocations = false;
          _showDistance = false;
        }
        isLoading = false; // Stop loading indicator
      });

      // Show success message via Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location sent successfully")),
      );
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
      });

      print('Error fetching location or calling API: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error while fetching location")),
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final postLData = Provider.of<FeatureView>(context, listen: false);

    return Scaffold(
      appBar: CustomDashApp(title: 'Map'),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Display loading indicator while waiting for API response
          : Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskData?['delivery_address'] ?? 'no address',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            backgroundColor: buttonColor,
                          ),
                          onPressed: () async {
                            if (isMessageTrue) {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                    child: Newo(
                                      task: taskData,
                                    ),
                                    type: PageTransitionType.fade,
                                  ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "Your are not close enough to go ahead")),
                              );
                            }
                          },
                          child: const Text(
                            'Reached To Location',
                            style: TextStyle(color: Colors.white, fontSize: 25),
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
