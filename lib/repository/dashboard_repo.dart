// import 'dart:convert';

// import 'package:flutter_application_1/constants/api_constant/routes/api_routes.dart';
// import 'package:flutter_application_1/data/network/BaseApiService.dart';
// import 'package:flutter_application_1/data/network/NetworkApiService.dart';

// import 'package:flutter_application_1/models/user_data.dart';
// import 'package:flutter_application_1/pages/dashboard/task_details/newla.dart';
// import 'package:flutter_application_1/view_model/get_main.dart';

// class HomeRepository {
//   BaseApiServices _apiServices = NetworkApiService();

//   Future<Welcome> fetchTechData() async {
//     try {
//       // Convert the data to JSON if not already done in `getPostApiResponse`
//       dynamic response = await _apiServices.getGetApiWithHeaderResponse(
//           AppUrl.userDataUrl, getHeader2);

//       print('am');

//       return response = Welcome.fromJson(response);
//     } catch (e) {
//       print('lololfffffffffffff');
//       print('❌❌❌ Login repo ----- $e');

//       throw e;
//     }
//   }
// }
// // class HomeRepository {
// //   BaseApiServices _apiServices = NetworkApiService();

// //   Future<MainDescriptionData> fetchTechData() async {
// //     try {
// //       // Convert the data to JSON if not already done in `getPostApiResponse`
// //       dynamic response = await _apiServices.getGetApiWithHeaderResponse(
// //           AppUrl.userDataUrl, getHeader2);

// //       print('am');

// //       return response = MainDescriptionData.fromJson(response);
// //     } catch (e) {
// //       print('lololfffffffffffff');
// //       print('❌❌❌ Login repo ----- $e');

// //       throw e;
// //     }
// //   }
// // }
