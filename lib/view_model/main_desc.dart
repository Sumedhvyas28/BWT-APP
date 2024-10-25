// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/repository/auth_repo.dart';
// import 'package:http/http.dart'as http;

// class AuthViewModel with ChangeNotifier {
//   final _myRepo = AuthRepository();
//   // final UserSession _userSession = UserSession(); // Instance of UserSession

// // Instance of UserSession

//   dynamic _isLoading = false;


//   get isLoading => _isLoading;

//   void setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   Future<bool> login(
//       String email, String password, BuildContext context) async {
//     setLoading(true);
//     try {
//       final Response = await http.post(
//         Uri.parse('https://mk.intouchsoftwaresolution.com/api/login'),
//         body: {
//           'email': email,
//           'password': password,
//         },
//       );

//       // Debugging
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         print('Login successful');

//         // Parse the response body to get user data
//         final userData = jsonDecode(response.body);

//         // Create User object from JSON
//         _user = User.fromJson(
//             userData['user']); // Ensure you parse the user data correctly

//         // Store user data in UserSession
//         await _userSession.storeUserData(userData);

//         // Update global data if necessary
//         GlobalData().updateEmailAddress(
//           newEmail: _user!.email,

//           // Assuming your API provides this
//           newRole: _user!.role,
//           newApiToken: userData['token'], // Assuming your API provides this
//         );

//         // Navigate to the appropriate screen based on user role

//         setLoading(false);
//         return true; // Indicate success
//       } else {
//         print('Login failed with status: ${response.statusCode}');
//         setLoading(false);
//         return false; // Indicate failure
//       }
//     } catch (e) {
//       print('Error: ${e.toString()}');
//       setLoading(false);
//       return false; // Indicate failure on exception
//     }
//   }
// }