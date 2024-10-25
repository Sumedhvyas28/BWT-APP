import 'package:flutter_application_1/constants/api_constant/routes/api_routes.dart';
import 'package:flutter_application_1/data/network/BaseApiService.dart';
import 'package:flutter_application_1/data/network/NetworkApiService.dart';
import 'package:flutter_application_1/models/product_description.dart';

class AuthRepository {
  BaseaApiServices _apiServices = NetworkApiService();

  // Future<dynamic> loginRepo(dynamic data) async {
  //   try {
  //     dynamic response = await _apiServices.getPostApiResponse( AppUrl.loginUrl, data);
  //     return response;
  //   } catch (e) {
  //     print('❌❌❌ Login repo ----- $e');
  //     throw e;
  //   }
  // }

  Future<List<Message>> showProductRepo(dynamic header) async {
    try {
      dynamic response = await _apiServices.getGetApiWithHeaderResponse(
          AppUrl.mainDescription, header);
      if (response is List) {
        return response.map((item) => Message.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load Product list data');
      }
    } catch (e) {
      print('❌❌ Show Product repo $e');
      throw e;
    }
  }
}
