import 'dart:convert';

import 'package:flutter_application_1/constants/api_constant/routes/api_routes.dart';
import 'package:flutter_application_1/data/network/BaseApiService.dart';
import 'package:flutter_application_1/data/network/NetworkApiService.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/view_model/get_main.dart';

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

      return response;
    } catch (e) {
      print('lololfffffffffffff');
      print('❌❌❌ Login repo ----- $e');

      throw e;
    }
  }

  Future<dynamic> updateSpareItems(dynamic data) async {
    print(jsonEncode(data));
    print('fetching');
    try {
      // Convert the data to JSON if not already done in `getPostApiResponse`
      final response = await _apiServices.getPostApiWithHeaderResponse(
          AppUrl.loginUrl, jsonEncode(data), postHeader);
      print('yes');

      return response;
    } catch (e) {
      print('lololfffffffffffff');
      print('❌❌❌ Login repo ----- $e');

      throw e;
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
}
