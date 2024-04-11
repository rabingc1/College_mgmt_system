import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internship/model.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key, required List<imageModel> data})
      : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? _selectedFaculty;
  String? _selectedSemester;
  String? _selectedGender;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _semesterController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _symbolController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();

  final bool _isLoading = false;
  List<String> facultyOptions = [
    'BBM',
    'BCA',
    'BBS',
    'BHM',
    'BIM',
    // Add more options here as needed
  ];
  List<String> SemesterOptions = [
    'First',
    'Second',
    'Third',
    'Fourth',
    'Fifth',
    'Sixth',
    'Seventh',
    'Eighth',
    // Add more options here as needed
  ];

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
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                   const Text(
                      "User Data Collection",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        prefixIcon: Icon(Icons.text_format),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Username';
                        }
                        return null;
                      },
                    ), //username
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        prefixIcon: Icon(Icons.text_format),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Address';
                        }
                        return null;
                      },
                    ), //address
                    const SizedBox(height: 20.0),
                    const Text(
                      'Select Faculty:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      value: _selectedFaculty,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Select Faculty',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                      items: facultyOptions.map((String faculty) {
                        return DropdownMenuItem<String>(
                          value: faculty,
                          child: Text(faculty),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a faculty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedFaculty = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),

                    const Text(
                      'Select Semester:',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      value: _selectedSemester,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Select Semester',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                      ),
                      items: SemesterOptions.map((String faculty) {
                        return DropdownMenuItem<String>(
                          value: faculty,
                          child: Text(faculty),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a Semester';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedSemester = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),

                    const Text(
                      'Select Gender:',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'Male',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        const Text('Male'),
                        Radio<String>(
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                        ),
                        const Text('Female'),
                      ],
                    ),

                    TextFormField(
                      controller: _symbolController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Symbol Number',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        prefixIcon: Icon(Icons.text_format),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Symbol number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Your PhoneNumber',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        prefixIcon: Icon(Icons.text_format),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Phone Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: _guardianController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Guardian Phone Number',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        prefixIcon: Icon(Icons.text_format),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Guardian Phone Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Perform your form submission here
                          // _registerUserAndCreateFirestoreDocument();
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
