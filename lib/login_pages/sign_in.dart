import 'dart:io';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:internship/homepage.dart';
import 'package:internship/login_pages/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vibration/vibration.dart';

import '../model.dart';
import '../user_auth/firebase_auth_services.dart';

class signin extends StatefulWidget {
  final List<imageModel> data;
  const signin({Key? key, required this.data}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseauthService _auth = FirebaseauthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            return await showDialog(
              context: context,
              builder: (context) => ExitConfirmationDialog(),
            );
          },
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(model[7].image), fit: BoxFit.cover),
                ),
                child: Column(
                  children: [
      
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 300, bottom: 0, right: 12),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              Container(
                                  height: 80,
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                    focusColor: Colors.orangeAccent,
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Email',
                                    prefixIcon: Icon(Icons.email)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  // Regular expression for email validation
                                  final emailRegex = RegExp(
                                      r'^[a-zA-Z0-9][a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                              Text(""),
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                    focusColor: Colors.orangeAccent,
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Password',
                                    prefixIcon: Icon(Icons.lock)),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value.length < 7) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                              Text(""),
      
                              ElevatedButton(
                                onPressed: () {
                                 _signin(context);
      
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // Form is validated, do something with the data
                                    print('Form validated');
      
                                    // Navigate to the next page here
                                  } else {
                                    // Form validation failed
                                    print('Form validation failed');
                                  }
                                },
                                child: Text('Submit'),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              homepage(data: widget.data)),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              signup(data: widget.data)),
                                    );
                                  },
                                  child: Text(
                                    "New Registration",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signin(BuildContext context) async {

    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User is successfully signed in  ',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => homepage(
                  data: model)), // Assuming 'Signin' is your destination screen
        );
      } else {

      }
      print("failed");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            behavior: SnackBarBehavior.fixed,
            content: Text(
                'User is not registered, Please registered to get start!!',
                style: TextStyle(color: Colors.white, fontSize: 13.5)),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      );

      print("Error signing in: $e");
      // Handle sign-in errors here
    }


  }
}

class ExitConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('CMS')),
      content: Text('Are you sure you want to exit?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            exit(
                0); // it will  Exit the app you recom.. xaina haii iphone ma tw 0 used garyeo vane account naii block gardenxa re
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
