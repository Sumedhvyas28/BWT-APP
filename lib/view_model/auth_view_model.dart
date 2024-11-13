import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/response/api_response.dart';
import 'package:flutter_application_1/repository/auth_repo.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  dynamic header = {
    HttpHeaders.authorizationHeader: 'token ${GlobalData().token}'
  };

  dynamic header1 = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'token ${GlobalData().token}'
  };

  ApiResponse userData = ApiResponse.loading();

  setUserData(ApiResponse response) {
    userData = response;
    notifyListeners();
  }

  Future<void> getUserData() async {
    setUserData(ApiResponse.loading());
    _myrepo.getUserDataRepo(header).then((value) {
      setUserData(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setUserData(ApiResponse.error(error.toString()));
    });
    notifyListeners();
  }

  Future<void> login(dynamic data, BuildContext context) async {
    setLoading(true);

    _myrepo.loginRepo(data).then((response) async {
      print('Login Response: $response'); // For debugging response

      if (response['message'] != null &&
          response['message']['status'] == 'success') {
        final apiKey = response['message']['user']['api_key']?.toString() ?? '';
        final apiSecret =
            response['message']['user']['api_secret']?.toString() ?? '';

        // Construct the authorization token (adjust format if needed)
        final authorizationToken = 'token $apiKey:$apiSecret';

        // Store user data with the authorization token
        final userData = {
          "token": apiKey,
          "apiSecret": apiSecret,
          "authToken": authorizationToken,
          "email": response['message']['user']['email'],
          "fullName": response['message']['user']['full_name'],
        };

        await Provider.of<UserSession>(context, listen: false)
            .storeUserData(userData);

        // Update headers for future requests
        header = {HttpHeaders.authorizationHeader: authorizationToken};

        // Navigate to the main page
        GoRouter.of(context).go('/home'); // Adjust route to your main page

        // Show a success message
        Utils.flushbarErrorMessage('User logged in successfully', context);
      } else {
        // Display specific error from API or a general message
        final errorMsg = response['message']?['message'] ?? 'Login failed';
        Utils.flushbarErrorMessage('Login failed: $errorMsg', context);
      }

      setLoading(false);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushbarErrorMessage('Wrong Credentials', context);
      print('Error: $error');
    });
  }
}
