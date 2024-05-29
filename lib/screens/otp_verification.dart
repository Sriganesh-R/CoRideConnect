import 'package:flutter/material.dart';
import 'package:login_signup/screens/signin_screen.dart';
import 'package:login_signup/screens/signup_screen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/style.dart';

import 'home.dart'; // Add this line

class OtpScreen extends StatelessWidget {
  final String previousPage;
  final String email; // Add this line
  OtpScreen({Key? key, required this.previousPage, required this.email}) : super(key: key);
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (previousPage == 'SignIn') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            } else if (previousPage == 'SignUp') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            }
          },
        ),
        title: Text('OTP Verification'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "CO\nDE",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 80.0),
              ),
              Text("Verification".toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 40.0),
              const Text("Enter the verification code sent at support@codingwitht.com", textAlign: TextAlign.center),
              const SizedBox(height: 20.0),
              OTPTextField(
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  length: 6,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 50,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (pin) {
                    _otpController.text = pin;
                    verifyOtpAndNavigate(context);
                  }),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () {}, child: const Text("Next")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyOtpAndNavigate(BuildContext context) {
    String enteredOtp = _otpController.text;

    if (enteredOtp == '135791') {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HelloWorldScreen()), // Replace HelloWorldScreen with the actual widget you want to navigate to in home.dart
          (route) => route.isFirst, // This will remove all routes except for the first one (i.e., the SignInScreen)
        );
      });
    } else {
      // OTP is incorrect, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
      );
    }
  }
}

