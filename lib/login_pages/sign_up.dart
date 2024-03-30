import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship/homepage.dart';
import 'package:internship/login_pages/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model.dart';
import '../user_auth/firebase_auth_services.dart';

class signup extends StatefulWidget {
  final List<imageModel> data;
  const signup({Key? key, required this.data}) : super(key: key);

  @override
  State<signup> createState() => _signinState();
}

class _signinState extends State<signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseauthService _auth = FirebaseauthService();


TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void dispose(){
    _usernameController.dispose();
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
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                            TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                  focusColor: Colors.orangeAccent,
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Full Name',
                                  prefixIcon: Icon(Icons.text_format)),
                              validator: (value){
                                if(value==null|| value.isEmpty){
                                  return 'please enter you full name';
                                }
                              },
                              onSaved: (value) {
      
                              },
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
                              onSaved: (value) {
      
                              },
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
                              onSaved: (value) {
      
                              },
                            ),
                            Text(""),
                            ElevatedButton(
                              onPressed: () {
                                _signup();
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
                                            signin(data: widget.data)),
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


  void _signup() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;



    User? user = await _auth.signUpWithEmailAndAndPassword(email,password);
    if(user!=null){
      print("user is registered");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => signin(data: model)),
      );
    }else{
      print("email is already in used or check it once");
    }

  }

}
