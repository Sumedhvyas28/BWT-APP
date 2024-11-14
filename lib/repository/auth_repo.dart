import 'dart:convert';

import 'package:flutter_application_1/constants/api_constant/routes/api_routes.dart';
import 'package:flutter_application_1/data/network/BaseApiService.dart';
import 'package:flutter_application_1/data/network/NetworkApiService.dart';
import 'package:flutter_application_1/models/going_for_visit.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/view_model/get_main.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  // Future<dynamic> signUpRepo(dynamic data) async {
  //   try {
  //     dynamic response =
  //         await _apiServices.getPostApiResponse(AppUrl().registerUrl, data);
  //     return response;
  //   } catch (e) {
  //     print('❌❌❌ Signup Repo ----- $e');
  //     throw e;
  //   }
  // }

  Future<dynamic> loginRepo(dynamic data) async {
    print(jsonEncode(data));
    print('fetching');
    try {
      // Convert the data to JSON if not already done in `getPostApiResponse`
      final response = await _apiServices.getPostApiWithHeaderResponse(
          AppUrl.loginUrl, jsonEncode(data), postHeader);
      print('yes');
      print("Request Headers: ${getHeader2()}");

      return response;
    } catch (e) {
      print('lololfffffffffffff');
      print('❌❌❌ Login repo ----- $e');

      throw e;
    }
  }

  Future<dynamic> updateSpareItems(String name, String status) async {
    // Structure the data according to the server's requirements
    final data = {
      "name": name,
      "status": status,
    };
    final headers = {
      // "Authorization": "token 45a6b57c35c5a19:8fd12351c087d9e",
      'Authorization': "${GlobalData().token}",

      "Content-Type": "application/x-www-form-urlencoded",
    };

    print("Request Headers: ${getHeader2()}");
    print("Request Data: ${jsonEncode(data)}");

    try {
      final response = await _apiServices.getPostApiWithHeaderResponse(
        AppUrl.updateSpareItemUrl,
        data, // Make sure data is encoded as JSON
        headers,
      );

      print("Response from API: $response");
      return response;
    } catch (e) {
      print("Error in Repository: $e");
      throw e;
    }
  }

  Future<Map<String, dynamic>> goingForVisit(String name) async {
    // Hardcoded JSON data for API request
    final data = jsonEncode({
      "name": "MAT-MVS-2024-00002",
    });

    final headers = {
      'Authorization': "${GlobalData().token}",
      "Content-Type": "application/json",
    };

    try {
      print(
          "Request data: $data"); // Debugging output to confirm request payload

      final response = await _apiServices.getPostApiWithHeaderResponse(
        AppUrl.goingForVisitUrl,
        data, // Send JSON-encoded string
        headers,
      );

      print("Response from API: $response");
      return response;
    } catch (e) {
      print("Error in API call: $e");
      rethrow;
    }
  }

  Future<UserData> getUserDataRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          AppUrl.userDataUrl, header);
      return response = UserData.fromJson(response);
    } catch (e) {
      print('❌❌ Error in getUserDataRepo Repo ${e}');
      throw e;
    }
  }

  Future<Map<String, dynamic>> punchInOut(String name) async {
    // Construct the request data dynamically using the provided `name`
    final data = {
      "maintenance_visit": name, // Using the dynamic name parameter here
      "punch_in": true, // As per your request body
    };

    final headers = {
      'Authorization': "${GlobalData().token}",
      "Content-Type": "application/json",
    };

    try {
      print(
          "Request data: ${jsonEncode(data)}"); // Debugging output to confirm request payload

      final response = await _apiServices.getPostApiWithHeaderResponse(
        AppUrl.punchInUrl, // Ensure you have the correct API URL
        jsonEncode(data), // Send JSON-encoded string
        headers,
      );

      print("Response from API: $response");
      return response;
    } catch (e) {
      print("Error in API call: $e");
      rethrow;
    }
  }
}
