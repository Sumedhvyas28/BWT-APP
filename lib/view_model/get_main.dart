import 'dart:io';

import 'package:flutter_application_1/view_model/user_session.dart';

String? authToken; // Declare the token as a variable

// Function to set authToken dynamically (for example, after login)
void setAuthToken(String token) {
  authToken = token; // Set the token dynamically
}

// Define dynamic headers
dynamic getHeader = {
  HttpHeaders.authorizationHeader: authToken != null ? 'Bearer $authToken' : '',
};

dynamic postHeader = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.authorizationHeader: authToken != null ? 'Bearer $authToken' : '',
};
// dynamic getHeader2 = {
//   'Authorization': 'token 45a6b57c35c5a19:8fd12351c087d9e',
//   'Content-Type': 'application/json',
// };

dynamic getHeader2 = {
  'Authorization': 'token ${GlobalData().token}',
  'Content-Type': 'application/json'
};
