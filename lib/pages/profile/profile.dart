import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/custom_appbar.dart';
import 'package:flutter_application_1/constants/drawer.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserSession>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'User Profile'),
      drawer: DrawerPage(),
      body: Stack(
        children: [
          // Main body content
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                color: Pallete.mainFontColor,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/userprofile.png'),
                    SizedBox(height: 10),
                    Text(
                      'Sumedh Vyas',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'user123456@gmail.com',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: ElevatedButton(
                onPressed: () async {
                  await userPreference.signOut().then((value) {
                    context.go('/login');
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Pallete.mainFontColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
