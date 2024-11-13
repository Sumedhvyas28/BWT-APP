import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession with ChangeNotifier {
  Future<void> storeUserData(dynamic userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(userData));
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
        newName: userData['name'] ?? '',
        newEmail: userData['email'] ?? '',
        newPhnNo: userData['phnNo'] ?? '',
        newCountry: userData['country'] ?? '',
        newRole: userData['role'] ?? '',
        newApiToken:
            userData['authToken'] ?? '', // Ensure the key matches stored data
      );
    }
  }
}

class GlobalData {
  static final GlobalData _instance = GlobalData._internal();
  factory GlobalData() => _instance;
  GlobalData._internal();

  String id = '';
  String name = '';
  String email = "user@gmail.com";
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
}
