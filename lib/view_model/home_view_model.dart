// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/data/response/api_response.dart';

// import 'package:flutter_application_1/models/user_data.dart';
// import 'package:flutter_application_1/pages/dashboard/task_details/newla.dart';
// import 'package:flutter_application_1/repository/dashboard_repo.dart';

// class HomeViewModel with ChangeNotifier {
//   final _myrepo = HomeRepository();

//   ApiResponse<UserDataL> dataList = ApiResponse.loading();

//   setDataList(ApiResponse<UserDataL> response) {
//     dataList = response;
//     notifyListeners();
//   }

//   Future<void> fetchMainData() async {
//     setDataList(ApiResponse.loading());
//     _myrepo.fetchTechData().then((value) {
//       setDataList(ApiResponse.completed(value));
//     }).onError(
//       (error, stackTrace) {
//         setDataList(ApiResponse.error(error.toString()));
//       },
//     );
//   }
// }
