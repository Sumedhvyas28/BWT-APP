import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/dashboard.dart';
import 'package:flutter_application_1/pallete.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size mediaSize;
  bool _isPasswordHidden = true;  // for pass 

  @override
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

  Widget _buildBottom(Size mediaSize) {
    return SizedBox(
      width: mediaSize.width,
      height: 580, 
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
          const SizedBox(height: 10,),
          Center(child: Image.asset('assets/logos/logo.png')),
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
  
 // login button 
  Widget _buildLoginButton(){
    return ElevatedButton(
      onPressed: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));

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
        ));
  }


// forgot password 
  Widget _buildForgotPassword(){
    return Center(
      child: TextButton(
        onPressed: (){}, 
        child: const Text(
          'Forgot Password ?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18),
            
            ),
            ),
      
    );
  }


// terms and services button  
  Widget _buildTermsButton(){
    return Center(
      child: TextButton(
        onPressed: (){}, 
        child: const Text(
          'Terms of Services',
          style: TextStyle(
            color: Pallete.termsFontColor,
            fontSize: 18),
            
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
                text: 'Terms & Conditions, by login in', 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                ),
              ),
            ],
          ),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            // height: 1.5, 
          ),
          textAlign: TextAlign.center, 
        ),
      );
    }
  
  
  
// skeleton for input field 
  Widget _buildGreyText(String text) {
    return TextField(
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
}
