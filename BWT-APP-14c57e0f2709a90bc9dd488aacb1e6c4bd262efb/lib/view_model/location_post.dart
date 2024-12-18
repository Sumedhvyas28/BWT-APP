import 'dart:async';
import 'package:flutter_background/flutter_background.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'feature_view.dart';
import 'user_session.dart';

class LocationViewModel extends ChangeNotifier {
  Timer? _locationUpdateTimer;

  Future<void> startLocationUpdates(FeatureView featureView) async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      debugPrint("Location services are not enabled.");
      return;
    }

    bool initialized = await FlutterBackground.initialize();
    if (!initialized) {
      debugPrint("FlutterBackground initialization failed.");
      return;
    }

    bool backgroundExecutionEnabled =
        await FlutterBackground.enableBackgroundExecution();
    if (!backgroundExecutionEnabled) {
      debugPrint("Failed to enable background execution.");
      return;
    }

    // Start periodic location updates
    _locationUpdateTimer ??= Timer.periodic(
      const Duration(seconds: 10),
      (_) async {
        try {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          await featureView.submitLocation(
            position.latitude.toString(),
            position.longitude.toString(),
          );
        } catch (e) {
          debugPrint("Failed to fetch or submit location: $e");
        }
      },
    );
  }

  void cancelLocationUpdates() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer = null;

    // Disable background execution
    FlutterBackground.disableBackgroundExecution();
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
