import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/constants/api_constant/routes/api_routes.dart';
import 'package:flutter_application_1/data/network/BaseApiService.dart';
import 'package:flutter_application_1/data/network/NetworkApiService.dart';
import 'package:flutter_application_1/models/going_for_visit.dart';
import 'package:flutter_application_1/models/post_location.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/view_model/get_main.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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
    final data = jsonEncode({
      "name": name, // Use the provided `name` value
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

  Future<Map<String, dynamic>> punchInOut(
      Map<String, dynamic> requestData) async {
    final headers = {
      'Authorization': "${GlobalData().token}",
      "Content-Type": "application/json",
    };

    try {
      print(
          "Request data: ${jsonEncode(requestData)}"); // Debugging output to confirm request payload

      final response = await _apiServices.getPostApiWithHeaderResponse(
        AppUrl.punchInUrl, // Ensure you have the correct API URL
        jsonEncode(requestData), // Send JSON-encoded string
        headers,
      );

      print("Response from API: $response");
      return response;
    } catch (e) {
      print("Error in API call: $e");
      rethrow;
    }
  }

  Future<Map<String, dynamic>> punchOut(String name) async {
    // Construct the request data dynamically using the provided `name`
    final data = {
      "maintenance_visit": name, // Using the dynamic name parameter here
      "punch_out": true, // As per your request body
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
      print("Response from API: tqnqttopq p o p op o p i p o");
      return response;
    } catch (e) {
      print("Error in API call: $e");
      rethrow;
    }
  }

  // add iamge save api here

  Future<Map<String, dynamic>> postImageWithMaintenanceVisitRepo(
      String maintenanceVisit, File image) async {
    // Construct the headers for the request
    final headers = {
      'Authorization': "${GlobalData().token}",
      "Content-Type":
          "multipart/form-data", // Content-Type is form-data since we're sending a file
    };

    try {
      // API URL to which the request will be sent
      var uri = Uri.parse(
          AppUrl.postAttachmentUrl); // Replace with your actual API URL

      // Prepare the multipart request
      var request = http.MultipartRequest('POST', uri);

      // Add the headers
      request.headers.addAll(headers);

      // Add the text field (maintenance_visit)
      request.fields['maintenance_visit'] = maintenanceVisit;

      // Add the image file
      var imageFile = await http.MultipartFile.fromPath(
        'image', // Field name for the image (must match the backend field name)
        image.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(imageFile);

      // Send the request
      var response = await request.send();

      // Handle response
      if (response.statusCode == 200) {
        print("Image and data uploaded successfully");
        final responseData = await http.Response.fromStream(response);
        print(responseData.body);
        return jsonDecode(responseData.body); // Return the response body
      } else {
        print('Failed to upload image. Status Code: ${response.statusCode}');
        return {'error': 'Failed to upload image'};
      }
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  Future<postLocation> postLocationData(
      Map<String, dynamic> requestBody) async {
    try {
      final body = jsonEncode(requestBody);

      final response = await _apiServices.getPostApiResponse(
        AppUrl.fetchLocation, // Replace with your endpoint URL.
        body,
      );

      if (response != null) {
        print(response['success']);
        print(response['message']);

        return postLocation.fromJson(response); // Adjusted model instantiation.
      } else {
        throw Exception('Error: No response from the server');
      }
    } catch (e) {
      throw Exception('Error posting message details: $e');
    }
  }

  Future<void> postLocationFive(String lat, String lon) async {
    final url =
        "https://bmscrmnew.bmscg.com:7070/api/method/field_service_management.api.live_location";

    // Ensure the token is available
    final token = GlobalData().token;
    if (token == null || token.isEmpty) {
      throw Exception("Authorization token is missing");
    }

    final headers = {
      'Authorization': "${GlobalData().token}",
      "Content-Type": "application/json",
    };

    // print("Headers: $headers");

    final body = json.encode({"lat": lat, "lon": lon});

    try {
      // Use the API service to send the request with headers
      final response =
          await _apiServices.getPostApiWithHeaderResponse(url, body, headers);
      // print(response);
      return response;
    } catch (e) {
      throw Exception("Failed to send location data: $e");
    }
  }

  Future<void> postTaskReschedule({
    required String maintenanceVisit,
    required String type,
    required String reason,
    required String date,
    required String hours,
  }) async {
    final url = AppUrl.rescheduleUrl;

    // Ensure the token is available
    final token = GlobalData().token;
    if (token == null || token.isEmpty) {
      throw Exception("Authorization token is missing");
    }

    final headers = {
      'Authorization': "$token",
      "Content-Type": "application/json",
    };

    final body = json.encode({
      "maintenance_visit": maintenanceVisit,
      "type": type,
      "reason": reason,
      "date": date,
      "hours": hours,
    });

    try {
      // Call the first API to reschedule
      final response = await http.post(
        Uri.parse(AppUrl.rescheduleUrl),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print("Task rescheduled successfully!");

        // If reschedule is successful, call the second API to punch out
        final punchOutResponse =
            await punchOut(maintenanceVisit); // Call punchOut method

        if (punchOutResponse['status'] == 'success') {
          print("Punch-out successful!");
        } else {
          throw Exception(
              "Failed to punch out: ${punchOutResponse['message']}");
        }
      } else {
        throw Exception(
            "Failed to reschedule task: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Error occurred during task reschedule or punch out: $e");
    }
  }
}
