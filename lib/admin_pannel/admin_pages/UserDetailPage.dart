import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final String userEmail;

  UserDetailPage({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Center(
        child: Text('Details for user: $userEmail'),
      ),
    );
  }
}
