import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class LocationViewModel extends ChangeNotifier {
  Timer? _locationUpdateTimer;

  void startLocationUpdates(FeatureView featureView) {
    if (_locationUpdateTimer != null) return; // Prevent multiple timers

    _locationUpdateTimer =
        Timer.periodic(const Duration(minutes: 5), (_) async {
      try {
        // Ensure the user is logged in
        if (GlobalData().token.isEmpty) {
          throw Exception("User is not logged in.");
        }

        // Get current location
        Map<String, double> location = await _getCurrentLocation();

        // Submit location data
        await featureView.submitLocation(
          location['latitude']!.toString(),
          location['longitude']!.toString(),
        );

        print(
            'Location sent: ${location['latitude']}, ${location['longitude']}');
      } catch (e) {
        print('Error updating location: $e');
      }
    });
  }

  void cancelLocationUpdates() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;
  }

  Future<Map<String, double>> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
}
