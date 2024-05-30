import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class adminuseraccount extends StatefulWidget {
  @override
  State<adminuseraccount> createState() => _adminuseraccountState();
}

class _adminuseraccountState extends State<adminuseraccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Admin Panel'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text('Error: ${snapshot.error ?? "No data"}'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot userDoc = snapshot.data!.docs[index];
              Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
              if (userData == null || !userData.containsKey('details')) {
                return ListTile(
                  title: Text('User Data Error'),
                  subtitle: Text('Details not found'),
                );
              }
              Map<String, dynamic>? userDetails = userData['details'];
              if (userDetails == null || !userDetails.containsKey('name') || !userDetails.containsKey('email') || !userDetails.containsKey('role')) {
                return ListTile(
                  title: Text('User Data Error'),
                  subtitle: Text('Details not found'),
                );
              }
              String name = userDetails['name'] ?? 'Name not defined';
              String email = userDetails['email'] ?? 'Email not defined';
              String role = userDetails['role'] ?? 'Role not defined';

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(name: name, email: email, role: role),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(name),
                  subtitle: Text(email),
                  trailing: Text(role),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  UserDetailsPage({required this.name, required this.email, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Email: $email', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Role: $role', style: TextStyle(fontSize: 18)),
            // Add more user details as needed
          ],
        ),
      ),
    );
  }
}
