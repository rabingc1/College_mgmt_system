import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class termsandcondition extends StatelessWidget {
  const termsandcondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              '1. Introduction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Welcome to the College Management System (CMS) app. These terms and conditions outline the rules and regulations for the use of our app.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '2. User Responsibilities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Users of this app are expected to:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '- Provide accurate and complete information during account setup.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Use the app for educational purposes and adhere to academic integrity standards.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            const Text(
              '3. Data Privacy and Security',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We are committed to protecting your privacy and the security of your personal information. Your data will be used according to our Privacy Policy.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            const Text(
              '4. Support and Contact Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            const Text(
              'For support inquiries or questions regarding these terms and conditions, please contact us:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                ),
                children: [
                  TextSpan(
                    text: 'Email: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'support@collegemanagement.com',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: 'Phone: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '01-5552860',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),

                  TextSpan(text: '\n'),
                  TextSpan(
                    text: 'Address: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Lalitpur Nepal.',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

