import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminUserAccount extends StatelessWidget {
  final List<String> faculties = ['BBM', 'BCA', 'BBS', 'BHM', 'BIM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin User Account'),
      ),
      body: ListView.builder(
        itemCount: faculties.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(faculties[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FacultyDetailPage(facultyName: faculties[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FacultyDetailPage extends StatelessWidget {
  final String facultyName;

  FacultyDetailPage({required this.facultyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$facultyName Details'),
      ),
      body: Center(
        child: Text('Details about $facultyName will be shown here.'),
      ),
    );
  }
}