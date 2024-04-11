import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _resetPassword(BuildContext context) async {

    String email = _emailController.text.trim();


    setState(() {
      _isLoading = true; // Set loading state to true
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Show success message and navigate back to sign-in screen
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Email Sent  Sucessfully'),
              content: Text('Please check your email to reset your password.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    Navigator.pop(context); // Navigate back to sign-in screen
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    } catch (error) {
      // Show error message if email sending fails
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Failed to send password reset email. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    focusColor: Colors.orangeAccent,
                    border: OutlineInputBorder(),
                    labelText: 'Enter registered  Email',
                    prefixIcon: Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your registered  email';
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
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _resetPassword(context);
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
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}

