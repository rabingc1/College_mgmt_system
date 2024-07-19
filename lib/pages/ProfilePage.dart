import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      setState(() {
        userData = snapshot.data();
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Profile Picture
          CircleAvatar(
            backgroundImage: userData!['profileImage'] != null
                ? NetworkImage(userData!['profileImage'])
                : null,
            child: userData!['profileImage'] == null
                ? Icon(
              Icons.person,
              size: 40,
            )
                : null,
            radius: 40,
          ),
          SizedBox(height: 16),
          // Name
          Center(
            child: Text(
              userData!['name'] ?? 'N/A',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 4),
          // Email
          Center(
            child: Text(
              userData!['email'] ?? 'N/A',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 20),
          // Other user details
          Card(
            child: ListTile(
              title: Text('Address'),
              subtitle: Text(userData!['address'] ?? 'N/A'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Phone Number'),
              subtitle: Text(userData!['phoneNumber'] ?? 'N/A'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Symbol Number'),
              subtitle: Text(userData!['symbolNumber'] ?? 'N/A'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Semester'),
              subtitle: Text(userData!['semester'] ?? 'N/A'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Guardian Phone Number'),
              subtitle: Text(userData!['guardianPhoneNumber'] ?? 'N/A'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Faculty'),
              subtitle: Text(userData!['faculty'] ?? 'N/A'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Documents'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (userData!['academicDocument'] is List<dynamic>)
                    ? (userData!['academicDocument'] as List<dynamic>)
                    .map((doc) => Text(doc.toString()))
                    .toList()
                    : [Text(userData!['academicDocument'].toString())],
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Documents'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (userData!['academicDocument'] is List<dynamic>)
                    ? (userData!['academicDocument'] as List<dynamic>)
                    .map((doc) => ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(doc.toString());
                    if (await canLaunch(url.toString())) {
                      await launch(url.toString());
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text('View Document'),
                ))
                    .toList()
                    : [Text(userData!['academicDocument'].toString())],
              ),
            ),
          ),


        ],
      ),
    );
  }
}
