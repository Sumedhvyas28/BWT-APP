import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/pallete.dart';
import 'package:flutter_application_1/pages/dashboard/task_details/map.dart';
import 'package:flutter_application_1/view_model/auth_view_model.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:flutter_application_1/view_model/location_post.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size mediaSize;
  bool _isPasswordHidden = true; // for password visibility toggle
  Timer? _locationUpdateTimer;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late LocationViewModel _locationViewModel;

  @override
  void initState() {
    super.initState();

    if (GlobalData().token.isNotEmpty) {
      final featureView = context.read<FeatureView>();
      _locationViewModel = context.read<LocationViewModel>();
      _locationViewModel.startLocationUpdates(featureView);
    }
  }

  @override
  void dispose() {
    _locationViewModel.cancelLocationUpdates();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: mediaSize.height,
            decoration: const BoxDecoration(
              color: Pallete.mainFontColor,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottom(mediaSize),
          ),
        ],
      ),
    );
  }

  // login container for bottom
  Widget _buildBottom(Size mediaSize) {
    return SizedBox(
      width: mediaSize.width,
      height: 600,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        color: Colors.white,
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/logos/logo.png',
                  height: 79,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'FIELD SERVICE MANAGEMENT',
                  style: TextStyle(
                      fontSize: 16,
                      color: Pallete.mainFontColor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildGreyText('Enter your Email'),
          const SizedBox(height: 20),
          _buildPasswordTextField('Enter your Password'),
          const SizedBox(height: 20),
          _buildForgotPassword(),
          const SizedBox(height: 20),
          _buildLoginButton(),
          const SizedBox(height: 20),
          _buildTermsAndCondition(),
          _buildTermsButton(),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    final authViewModel = context.read<AuthViewModel>();

    return ElevatedButton(
      onPressed: () async {
        try {
          Map data = {
            "email": emailController.text.trim(),
            "password": passwordController.text.trim(),
          };

          await context.read<AuthViewModel>().login(data, context);

          // double latitude = 37.4219983;
          // double longitude = -122.084;
          // await context
          //     .read<FeatureView>()
          //     .submitLocation(latitude.toString(), longitude.toString());

          if (GlobalData().token.isNotEmpty) {
            final featureView =
                context.read<FeatureView>(); // Obtain the FeatureView instance
            context.read<LocationViewModel>().startLocationUpdates(featureView);
          }
        } catch (e) {
          print('Error during login or location updates: $e');
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        backgroundColor: Pallete.mainFontColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  // forgot password
  Widget _buildForgotPassword() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password ?',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }

  // terms and services button
  Widget _buildTermsButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'Terms of Services',
          style: TextStyle(color: Pallete.termsFontColor, fontSize: 18),
        ),
      ),
    );
  }

  // terms and condition text
  Widget _buildTermsAndCondition() {
    return const Center(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'I agree with all the\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'Terms & Conditions, by logging in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // skeleton for input field
  Widget _buildGreyText(String text) {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  // password show / hide field
  Widget _buildPasswordTextField(String text) {
    return TextField(
      controller: passwordController,
      obscureText: _isPasswordHidden,
      decoration: InputDecoration(
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
        ),
      ),
    );
  }

  // Location function to get current coordinates
  Future<Map<String, double>> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationServiceDialog();
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return {'latitude': position.latitude, 'longitude': position.longitude};
  }

  // Show dialog if location service is disabled
  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Location Services Disabled'),
          content: Text('Please enable location services to proceed.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
