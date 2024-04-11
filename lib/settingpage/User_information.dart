


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship/pages/setting.dart';


class userinformation extends StatefulWidget {
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<userinformation> {
  late User _user; // Firebase user object
  late Stream<DocumentSnapshot> _userStream; // Firestore document stream

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!; // Get current authenticated user
    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .snapshots(); // Firestore stream for user document
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('No data available'));
          }

          // Retrieve user data from Firestore document
          Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
          String name = userData['name'] ?? '';
          String email = userData['email'] ?? '';
          String address= userData['Address']?? '';

          return
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                margin: const EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: $name', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Email: $email', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Address: $address', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }



}
