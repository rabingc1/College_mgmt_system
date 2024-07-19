
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registeradmin extends StatefulWidget {
  const Registeradmin({super.key});

  @override
  State<Registeradmin> createState() => _RegisteradminState();
}

class _RegisteradminState extends State<Registeradmin> {
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
        // On Android, auto-retrieval or instant verification can happen.
        await _auth.signInWithCredential(credential);
        print("Phone number automatically verified and user signed in: ${_auth
            .currentUser?.uid}");
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
        print('Phone number verification failed. Code: ${e.code}. Message: ${e
            .message}');
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
      UserCredential userCredential = await _auth.signInWithCredential(
          credential);
      print("Successfully signed in UID: ${userCredential.user?.uid}");

      // Now create a user with email and password
      String email = '${phoneController.text}@example.com';
      UserCredential newUserCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: passwordController.text,
      );

      print(
          "Successfully created user with email and password: ${newUserCredential
              .user?.uid}");
    } catch (e) {
      print("Failed to sign in: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              child: Image.asset("images/logo.png"),
            ),
            SizedBox(height: 20),
            Container(
              height: 40,
              child: const Text(
                "College Management System",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: 50,
                child: const Text(
                  "Create Admin Account",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
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
              child: Text(otpSent ? 'Submit OTP' : 'Register'),
            ),
          ],
        ),
      ),
    );
  }
}
