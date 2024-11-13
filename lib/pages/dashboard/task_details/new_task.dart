// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/data/response/status.dart';
// import 'package:flutter_application_1/view_model/home_view_model.dart';
// import 'package:provider/provider.dart';

// class NewTask extends StatefulWidget {
//   const NewTask({super.key});

//   @override
//   State<NewTask> createState() => _NewTaskState();
// }

// class _NewTaskState extends State<NewTask> {
//   HomeViewModel homeViewModel = HomeViewModel();

//   @override
//   void initState() {
//     // TODO: implement initState
//     homeViewModel.fetchMainData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: ChangeNotifierProvider<HomeViewModel>(
//           create: (BuildContext context) => homeViewModel,
//           child: Consumer<HomeViewModel>(builder: (context, value, _) {
//             switch (value.dataList.status) {
//               case Status.LOADING:
//                 return CircularProgressIndicator();

//               case Status.ERROR:
//                 return Text(value.dataList.message.toString());

//               case Status.COMLETED:
//                 return Center(child: Text('hurururua'));

//               case null:
//                 return Container();
//             }
//           }),
//         ));
//   }
// }
