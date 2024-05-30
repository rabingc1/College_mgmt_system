import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship/admin_pannel/AdminPanel.dart';
  // Ensure you have created home_page.dart as per the previous instructions.
import 'sign_up.dart';  // Ensure you have created sign_up.dart for the registration page.

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = '';
  bool otpSent = false;

  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        _navigateToHomePage();
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          otpSent = true;
          this.verificationId = verificationId;
        });
        print('Please check your phone for the verification code.');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
        print("verification code: " + verificationId);
      },
    );
  }

  void _signInWithPhoneNumber() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text,
    );
    try {
      await _auth.signInWithCredential(credential);
      _navigateToHomePage();
    } catch (e) {
      print("Failed to sign in: " + e.toString());
    }
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AdminPanel()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 200,
                  child: Image.asset("images/logo.png")
              ),
              Container(
                  height: 40,
                  child: const Text(
                    "College Management System",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  height: 50,
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              Container(
                  height: 40,
                  child: const Text(
                    "Admin Panel",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
             /* TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),*/
              SizedBox(height: 20),
              if (otpSent)
                TextField(
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: otpSent ? _signInWithPhoneNumber : _verifyPhoneNumber,
                child: Text(otpSent ? 'Submit OTP' : 'Login'),
              ),
              TextButton(
                onPressed: () {
                  // Implement forgot password functionality here
                  print('Forgot Password tapped');
                },
                child: Text('Forgot Password?'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registeradmin()),
                  );
                },
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
