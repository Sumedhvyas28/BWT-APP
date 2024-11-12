import 'dart:io';

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
