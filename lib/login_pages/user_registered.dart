import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship/login_pages/sign_in.dart';
import 'package:internship/model.dart';

class Userregistration extends StatefulWidget {
  const Userregistration({super.key, required List<imageModel> data});

  @override
  State<Userregistration> createState() => _UserregistrationState();
}

class _UserregistrationState extends State<Userregistration> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;
  Future<void> _registerUserAndCreateFirestoreDocument() async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    try {
      // Register the user with email and password using Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Access the newly created user
      User? user = userCredential.user;

      // Create a new document in Firestore for the user
      if (user != null) {

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          // You can add more fields as needed

        });


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  signin(data: model)), // Navigate to SignInPage
        );

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User is successfully signed in  ',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ));
      } else {
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

        print("Error: user registration failed");
      }
    } catch (error) {
      print('Error registering user and creating Firestore document: $error');
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(model[12].image), fit: BoxFit.cover),
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
                                  "Sign Up",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                  focusColor: Colors.orangeAccent,
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Full Name',
                                  prefixIcon: Icon(Icons.text_format)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'please enter you full name';
                                }
                              },
                              onSaved: (value) {},
                            ),
                            Text(""),
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
                                  labelText: 'Please Set Password',
                                  prefixIcon: Icon(Icons.lock)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Set your password';
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
                                if (_formKey.currentState!.validate()) {
                                  _registerUserAndCreateFirestoreDocument();
                                }
                              },
                              child:
                              _isLoading
                                  ? CircularProgressIndicator()
                             : Text('Register'),
                            ),

                            /* ElevatedButton(
                              onPressed: () {
                                _registerUserAndCreateFirestoreDocument;
                                if (_formKey.currentState!.validate()) {

                                  _formKey.currentState!.save();
                                  // Form is validated, do something with the data

                                  // Navigate to the next page here
                                } else {
                                  // Form validation failed
                                }
                              },
                              child: Text('Submit'),
                            ),*/
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            signin(data: model)),
                                  );
                                },
                                child: Text(
                                  "Back To Sign In",
                                  style: TextStyle(
                                      fontSize: 13,
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
    );
  }
}
