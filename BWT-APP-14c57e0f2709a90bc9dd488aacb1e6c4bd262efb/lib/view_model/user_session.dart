import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:flutter_application_1/view_model/location_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession with ChangeNotifier {
  Future<void> startLocationUpdatesIfLoggedIn(
      LocationViewModel locationViewModel, FeatureView featureView) async {
    final isLoggedIn = await this.isLoggedIn();
    if (isLoggedIn) {
      locationViewModel.startLocationUpdates(featureView);
    }
  }

  Future<void> storeUserData(dynamic userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(userData));
    GlobalData().updateUserData(
      newId: userData['id'] ?? '',
      newName: userData['full_name'] ?? '',
      newEmail: userData['email'] ?? '',
      newPhnNo: userData['phnNo'] ?? '',
      newCountry: userData['country'] ?? '',
      newRole: userData['role'] ?? '',
      newApiToken: userData['authToken'] ?? '',
    );
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('userData');
    if (userData != null) {
      return jsonDecode(userData);
    }
    return null;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    GlobalData().clearUserData(); // Clear global data on sign-out
  }

  Future<bool> isLoggedIn() async {
    final userData = await getUserData();
    return userData != null;
  }

  Future<void> loadUserDataIntoGlobal() async {
    final userData = await getUserData();
    if (userData != null) {
      GlobalData().updateUserData(
        newId: userData['id'] ?? '',
        newName: userData['full_name'] ?? '',
        newEmail: userData['email'] ?? '',
        newPhnNo: userData['phnNo'] ?? '',
        newCountry: userData['country'] ?? '',
        newRole: userData['role'] ?? '',
        newApiToken: userData['authToken'] ?? '',
      );
    }
  }
}

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();
  factory GlobalData() => _instance;
  GlobalData._internal();

  static final UserSession userSession = UserSession();

  String id = '';
  String name = '';
  String email = '';
  String phnNo = '';
  String country = '';
  String role = '';
  String token = '';

  void updateUserData({
    required String newId,
    required String newName,
    required String newEmail,
    required String newPhnNo,
    required String newCountry,
    required String newRole,
    required String newApiToken,
  }) {
    id = newId;
    name = newName;
    email = newEmail;
    phnNo = newPhnNo;
    country = newCountry;
    role = newRole;
    token = newApiToken;
  }

  void clearUserData() {
    id = '';
    name = '';
    email = '';
    phnNo = '';
    country = '';
    role = '';
    token = '';
  }
}
