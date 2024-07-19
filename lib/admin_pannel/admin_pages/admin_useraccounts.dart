import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<Map<String, Map<String, List<UserModel>>>> _usersByFacultyAndSemester;
  String? _selectedFaculty;
  String? _selectedSemester;

  @override
  void initState() {
    super.initState();
    _usersByFacultyAndSemester = fetchUsersByFacultyAndSemester();
  }

  void _showEditDialog(UserModel user) {
    final _nameController = TextEditingController(text: user.name);
    final _emailController = TextEditingController(text: user.email);
    final _addressController = TextEditingController(text: user.address);
    final _facultyController = TextEditingController(text: user.faculty);
    final _genderController = TextEditingController(text: user.gender);
    final _guardianPhoneNumberController = TextEditingController(text: user.guardianPhoneNumber);
    final _phoneNumberController = TextEditingController(text: user.phoneNumber);
    final _semesterController = TextEditingController(text: user.semester);
    final _symbolNumberController = TextEditingController(text: user.symbolNumber);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
                TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
                TextField(controller: _addressController, decoration: InputDecoration(labelText: 'Address')),
                TextField(controller: _facultyController, decoration: InputDecoration(labelText: 'Faculty')),
                TextField(controller: _genderController, decoration: InputDecoration(labelText: 'Gender')),
                TextField(controller: _guardianPhoneNumberController, decoration: InputDecoration(labelText: 'Guardian Phone Number')),
                TextField(controller: _phoneNumberController, decoration: InputDecoration(labelText: 'Phone Number')),
                TextField(controller: _semesterController, decoration: InputDecoration(labelText: 'Semester')),
                TextField(controller: _symbolNumberController, decoration: InputDecoration(labelText: 'Symbol Number')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateUser(
                  user.id,
                  _nameController.text,
                  _emailController.text,
                  _addressController.text,
                  _facultyController.text,
                  _genderController.text,
                  _guardianPhoneNumberController.text,
                  _phoneNumberController.text,
                  _semesterController.text,
                  _symbolNumberController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateUser(
      String userId,
      String name,
      String email,
      String address,
      String faculty,
      String gender,
      String guardianPhoneNumber,
      String phoneNumber,
      String semester,
      String symbolNumber,
      ) {
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'name': name,
      'email': email,
      'address': address,
      'faculty': faculty,
      'gender': gender,
      'guardianPhoneNumber': guardianPhoneNumber,
      'phoneNumber': phoneNumber,
      'semester': semester,
      'symbolNumber': symbolNumber,
    }).then((_) {
      setState(() {
        _usersByFacultyAndSemester = fetchUsersByFacultyAndSemester();
      });
    });
  }

  void _deleteUser(String userId) {
    FirebaseFirestore.instance.collection('users').doc(userId).delete().then((_) {
      setState(() {
        _usersByFacultyAndSemester = fetchUsersByFacultyAndSemester();
      });
    });
  }

  void _showUserDetailsDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(user.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${user.email}'),
                Text('Address: ${user.address}'),
                Text('Faculty: ${user.faculty}'),
                Text('Gender: ${user.gender}'),
                Text('Guardian Phone Number: ${user.guardianPhoneNumber}'),
                Text('Phone Number: ${user.phoneNumber}'),
                Text('Semester: ${user.semester}'),
                Text('Symbol Number: ${user.symbolNumber}'),
                SizedBox(height: 16),
                if (user.profileImage.isNotEmpty) Image.network(user.profileImage),
                if (user.academicDocument != null) Image.network(user.academicDocument!),
                if (user.document1 != null) Image.network(user.document1!),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showDeleteDialog(user.id);
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteUser(userId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, Map<String, List<UserModel>>>> fetchUsersByFacultyAndSemester() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    List<UserModel> users = querySnapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();

    Map<String, Map<String, List<UserModel>>> facultySemesterMap = {};
    for (var user in users) {
      if (user.faculty.isNotEmpty && user.semester.isNotEmpty) {
        if (!facultySemesterMap.containsKey(user.faculty)) {
          facultySemesterMap[user.faculty] = {};
        }
        if (!facultySemesterMap[user.faculty]!.containsKey(user.semester)) {
          facultySemesterMap[user.faculty]![user.semester] = [];
        }
        facultySemesterMap[user.faculty]![user.semester]!.add(user);
      }
    }
    return facultySemesterMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: FutureBuilder<Map<String, Map<String, List<UserModel>>>>(
        future: _usersByFacultyAndSemester,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            final facultySemesterMap = snapshot.data!;
            final faculties = facultySemesterMap.keys.toList();
            final semesters = _selectedFaculty == null
                ? []
                : facultySemesterMap[_selectedFaculty!]!.keys.toList();

            return Column(
              children: [
                DropdownButton<String>(
                  value: _selectedFaculty,
                  hint: Text('Select Faculty'),
                  onChanged: (value) {
                    setState(() {
                      _selectedFaculty = value;
                      _selectedSemester = null; // Reset semester selection
                    });
                  },
                  items: faculties.map((faculty) {
                    return DropdownMenuItem<String>(
                      value: faculty,
                      child: Text(faculty),
                    );
                  }).toList(),
                ),
                if (_selectedFaculty != null) ...[
                  DropdownButton<String>(
                    value: _selectedSemester,
                    hint: Text('Select Semester'),
                    onChanged: (value) {
                      setState(() {
                        _selectedSemester = value;
                      });
                    },
                    items: semesters.map((semester) {
                      return DropdownMenuItem<String>(
                        value: semester,
                        child: Text(semester),
                      );
                    }).toList(),
                  ),
                ],
                Expanded(
                  child: ListView.builder(
                    itemCount: _selectedFaculty == null || _selectedSemester == null
                        ? 0
                        : facultySemesterMap[_selectedFaculty!]?[_selectedSemester!]!.length ?? 0,
                    itemBuilder: (context, index) {
                      UserModel user = facultySemesterMap[_selectedFaculty!]![_selectedSemester!]![index];
                      return Card(
                        color: Colors.blue[100],
                        elevation: 8,
                        child: ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: PopupMenuButton<String>(
                            onSelected: (String value) {
                              if (value == 'edit') {
                                _showEditDialog(user);
                              } else if (value == 'delete') {
                                _showDeleteDialog(user.id);
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return {'edit', 'delete'}.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                          onTap: () {
                            _showUserDetailsDialog(user);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class UserModel {
  String id;
  String name;
  String email;
  String address;
  String faculty;
  String gender;
  String guardianPhoneNumber;
  String phoneNumber;
  String profileImage;
  String? academicDocument;
  String? document1;
  String semester;
  String symbolNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.faculty,
    required this.gender,
    required this.guardianPhoneNumber,
    required this.phoneNumber,
    required this.profileImage,
    this.academicDocument,
    this.document1,
    required this.semester,
    required this.symbolNumber,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    return UserModel(
      id: doc.id,
      name: data?['name'] ?? '',
      email: data?['email'] ?? '',
      address: data?['address'] ?? '',
      faculty: data?['faculty'] ?? '',
      gender: data?['gender'] ?? '',
      guardianPhoneNumber: data?['guardianPhoneNumber'] ?? '',
      phoneNumber: data?['phoneNumber'] ?? '',
      profileImage: data?['profileImage'] ?? '',
      academicDocument: data?['academicDocument'],
      document1: data?['document1'],
      semester: data?['semester'] ?? '',
      symbolNumber: data?['symbolNumber'] ?? '',
    );
  }
}
