import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/repository/auth_repo.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FeatureView with ChangeNotifier {
  static final AuthRepository _myRepo = AuthRepository();
  String? _message;
  bool _isLoading = false;

  String? get message => _message;
  bool get isLoading => _isLoading;
  String _distanceMessage = '';
  String get distanceMessage => _distanceMessage;
  String? errorMessage;

  // Method to post image with maintenance visit
  Future<void> postImageWithMaintenanceVisit(
      String maintenanceVisit, File image) async {
    try {
      _isLoading = true;
      errorMessage = null;
      notifyListeners(); // Notify listeners to rebuild UI

      var response = await _myRepo.postImageWithMaintenanceVisitRepo(
        maintenanceVisit,
        image,
      );

      if (response['error'] != null) {
        errorMessage = response['error'];
      } else {
        // Handle the response if needed (e.g., show success message)
      }
    } catch (e) {
      errorMessage = 'Failed to upload image: $e';
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners to rebuild UI
    }
  }

  Future<void> saveCheckboxState(List<bool> states) async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < states.length; i++) {
      await prefs.setBool(
          'checkbox_state_$i', states[i]); // Store each state with a unique key
    }
  }

  // Method to load checkbox state
  Future<List<bool>> loadCheckboxState(int itemCount) async {
    final prefs = await SharedPreferences.getInstance();
    List<bool> loadedStates = [];
    for (int i = 0; i < itemCount; i++) {
      bool? state = prefs
          .getBool('checkbox_state_$i'); // Fetch stored state for each checkbox
      loadedStates.add(state ?? false); // If no value found, default to false
    }
    return loadedStates;
  }

  Future<void> updateSpareItem(String name, String status) async {
    _isLoading = true;

    notifyListeners();

    final data = {"name": name, "status": status}; // Payload with "yes" or "no"

    try {
      final response = await _myRepo.updateSpareItems(name, status);

      // Debugging: Print response to check structure
      print("Response: $response");

      // Ensure the response contains a message and status as expected
      if (response['message'] != null &&
          response['message']['status'] == 'success') {
        final collectedStatus = response['message']['collected'];

        // Check if the collected status matches the sent status
        if (collectedStatus == status) {
          _message = response['message']['message'];
        } else {
          _message =
              "Mismatch in status: Expected '$status', got '$collectedStatus'";
        }
      } else {
        _message = 'Update failed';
      }
    } catch (e) {
      _message = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

// add here that going for visit for vuiew model and it is different from model
// For going for visit
  Future<void> goingForVisitRepo(String name) async {
    print("API called with name: $name");
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'name': name,
    };

    try {
      final response = await _myRepo.goingForVisit(name);
      print("Response from goingForVisit API: $response");

      if (response != null && response['message'] != null) {
        _message = response['message']['message'];
      } else {
        _message = 'Request failed or invalid response';
      }
    } catch (e) {
      _message = 'An error occurred: $e';
      print('Error in goingForVisit: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> punchInRepo(String name) async {
    print("API called with name: $name");
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'name': name,
    };

    try {
      final response = await _myRepo
          .punchInOut(name); // Call the punchIn method from the repository
      print("Response from punchIn API: $response");

      if (response != null && response['message'] != null) {
        _message = response['message']
            ['message']; // Assign the message from the response
      } else {
        _message = 'Request failed or invalid response';
      }
    } catch (e) {
      _message = 'An error occurred: $e';
      print('Error in punchIn: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> punchOutRepo(String name) async {
    print("API called with name: $name");
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> data = {
      'name': name,
    };

    try {
      final response = await _myRepo
          .punchInOut(name); // Call the punchIn method from the repository
      print("Response from punchIn API: $response");

      if (response != null && response['message'] != null) {
        _message = response['message']
            ['message']; // Assign the message from the response
      } else {
        _message = 'Request failed or invalid response';
      }
    } catch (e) {
      _message = 'An error occurred: $e';
      print('Error in punchIn: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  static Future<void> postLocationDistance(
      double lat1, double lon1, double lat2, double lon2) async {
    try {
      final data = {
        'lat1': lat1,
        'lon1': lon1,
        'lat2': lat2,
        'lon2': lon2,
      };

      final jsonData = jsonEncode(data);
      final response = await _myRepo.postLocation(jsonData);

      if (response['message']['status'] == 'success') {
        print('Distance: ${response['message']['distance']}');
      } else {
        print('Failed to fetch distance');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
