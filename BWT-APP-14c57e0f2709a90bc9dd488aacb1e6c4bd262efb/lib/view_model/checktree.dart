import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/api_constant/routes/api_routes.dart';
import 'package:flutter_application_1/models/symptom.dart';
import 'package:flutter_application_1/repository/auth_repo.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Checktree with ChangeNotifier {
  static final AuthRepository _myRepo = AuthRepository();

  final instance = Checktree; // Replace with the actual class name

  String? _message;

// Update Checktree Repo with 'yes' or 'no' for work_done
  static Future<void> updateChecktreeRepo(String name,
      {String work_done = 'yes'}) async {
    final Map<String, dynamic> requestData = {
      "name": name,
      "status": work_done, // 'yes' or 'no'
    };

    final headers = {
      'Authorization': "${GlobalData().token}",
      "Content-Type": "application/json",
    };

    try {
      final String jsonBody = jsonEncode(requestData);

      final http.Response response = await http.post(
        Uri.parse(AppUrl.updateChecktreeUrl),
        body: jsonBody,
        headers: headers,
      );

      final jsonResponse = jsonDecode(response.body);
      print("Response from API: $jsonResponse");

      return jsonResponse;
    } catch (e) {
      print("Error in API call: $e");
      rethrow;
    }
  }

  static Future<void> technicianNotes(
      String name, String note, BuildContext context) async {
    final Map<String, dynamic> requestData = {
      "maintenance_visit": name,
      "note": note,
    };

    final headers = {
      'Authorization': "${GlobalData().token}",
      "Content-Type": "application/json",
    };

    try {
      final String jsonBody = jsonEncode(requestData);

      final http.Response response = await http.post(
        Uri.parse(AppUrl.updateTechnicianNotes),
        body: jsonBody,
        headers: headers,
      );

      final jsonResponse = jsonDecode(response.body);
      print("Response from API: $jsonResponse");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Notes updated successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update notes.')),
        );
      }

      return jsonResponse;
    } catch (e) {
      print("Error in API call: $e");
      rethrow;
    }
  }

  static Future<void> addSymptomsRequest(
    String name,
    String item_code,
    BuildContext context, {
    required List<SymptomData> symptomsData,
  }) async {
    var uri = Uri.parse(AppUrl.updateSymptomTable);

    var request = http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = "${GlobalData().token}";

    request.fields['maintenance_visit'] = name;
    request.fields['item_code'] = item_code;

    for (int i = 0; i < symptomsData.length; i++) {
      var symptom = symptomsData[i];

      request.fields['symptoms[$i][symptom_code]'] = symptom.symptom;
      request.fields['symptoms[$i][resolution]'] = symptom.solution;
      if (symptom.image != null) {
        var imageBytes = await symptom.image!.readAsBytes();
        var image = http.MultipartFile.fromBytes(
          'symptoms[$i][image]',
          imageBytes,
          filename: 'image_[$i].jpg',
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(image);
      }
    }

    // Send the request and get the response
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Request was successful!");
      final responseBody = await response.stream.bytesToString();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added Symptoms successfully!')),
      );

      print(responseBody);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add Symptoms')),
      );
      print("Error: ${response.statusCode}");
    }
  }
}
