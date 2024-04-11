import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class suport_page extends StatefulWidget {
  const suport_page({super.key});

  @override
  State<suport_page> createState() => _suport_pageState();
}

class _suport_pageState extends State<suport_page> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Support"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome to the College Management System (CMS) support page!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              const Text(
                "Our dedicated support team is here to assist you with any questions, concerns, or issues you may have while using our system. Whether you're a student, faculty member, or administrative staff, we strive to provide prompt and effective support to ensure your experience with CMS is smooth and productive.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "At CMS support, we offer assistance with a wide range of topics, including account setup, navigation within the system, course registration, grading inquiries, technical troubleshooting, and more. Our team is committed to addressing your needs promptly and professionally, guiding you through any challenges you encounter while utilizing our platform.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "For immediate assistance, please feel free to reach out to us via our contact channels, which include ",
                    ),
                    TextSpan(
                      text: "email (support@collegemanagement.com)",
                      style: TextStyle(
                        color: Colors.blue, // Blue color for email
                        decoration: TextDecoration.underline, // Underline for email
                      ),
                    ),
                    TextSpan(
                      text: ", phone ",
                    ),
                    TextSpan(
                      text: "(01-5552860)",
                      style: TextStyle(
                        color: Colors.blue, // Blue color for phone number
                        decoration: TextDecoration.underline, // Underline for phone number
                      ),
                    ),
                    TextSpan(
                      text: ", or by submitting a support ticket directly through our system. We value your feedback and are continuously working to enhance the CMS user experience based on your input.",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Thank you for choosing the College Management System. We look forward to assisting you and ensuring your success with our comprehensive educational platform.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


