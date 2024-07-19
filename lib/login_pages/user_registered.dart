import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship/login_pages/sign_in.dart';
import 'package:internship/model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserRegistration extends StatefulWidget {
  final List<imageModel> data;

  const UserRegistration({super.key, required this.data});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  String? _selectedFaculty;
  String? _selectedSemester;
  String? _selectedGender;
  File? _profileImage;
  File? _academicDocument;
  File? _document1;
  File? _document2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _symbolController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  List<String> facultyOptions = [
    'BBM',
    'BCA',
    'BBS',
    'BHM',
    'BIM',
  ];

  List<String> semesterOptions = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];

  Future<void> _pickImage(ImageSource source, bool isProfileImage, [bool? isDocument1, bool? isDocument2]) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isProfileImage) {
          _profileImage = File(pickedFile.path);
        } else if (isDocument1 == true) {
          _document1 = File(pickedFile.path);
        }  else {
          _academicDocument = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _registerUserAndCreateFirestoreDocument() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          String? profileImageUrl;
          String? academicDocumentUrl;
          String? document1Url;
          String? document2Url;

          if (_profileImage != null) {
            profileImageUrl = await _uploadFile(_profileImage!, 'profile_images/${user.uid}.jpg');
          }

          if (_academicDocument != null) {
            academicDocumentUrl = await _uploadFile(_academicDocument!, 'academic_documents/${user.uid}.jpg');
          }

          if (_document1 != null) {
            document1Url = await _uploadFile(_document1!, 'documents/document1_${user.uid}.jpg');
          }


          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': _usernameController.text.trim(),
            'address': _addressController.text.trim(),
            'faculty': _selectedFaculty,
            'semester': _selectedSemester,
            'gender': _selectedGender,
            'symbolNumber': _symbolController.text.trim(),
            'phoneNumber': _phoneController.text.trim(),
            'guardianPhoneNumber': _guardianController.text.trim(),
            'email': _emailController.text.trim(),
            'profileImage': profileImageUrl,
            'academicDocument': academicDocumentUrl,
            'document1': document1Url,

          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => signin(data: widget.data)),
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User successfully registered and signed in',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.fixed,
            content: Text('Registration failed. Please try again.',
                style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<String> _uploadFile(File file, String path) async {
    UploadTask uploadTask =
    FirebaseStorage.instance.ref().child(path).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Registration"),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/backpic.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          " Please provide the information accurately based on the document.",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold,color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.text_format),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Full Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Address',
                          prefixIcon: Icon(Icons.location_on),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5.0),
                      const Text('Select Faculty:',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5.0),
                      DropdownButtonFormField<String>(
                        value: _selectedFaculty,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select Faculty',
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
                      const SizedBox(height: 5.0),
                      const Text('Select Semester:',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 5.0),
                      DropdownButtonFormField<String>(
                        value: _selectedSemester,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select Semester',
                        ),
                        items: semesterOptions.map((String semester) {
                          return DropdownMenuItem<String>(
                            value: semester,
                            child: Text(semester),
                          );
                        }).toList(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a semester';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _selectedSemester = value;
                          });
                        },
                      ),
                      const SizedBox(height: 5.0),
                      const Text('Select Gender:',
                          style: TextStyle(fontSize: 16)),
                      Row(
                        children: <Widget>[
                          Radio<String>(
                            value: 'Male',
                            groupValue: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          const Text('Male'),
                          Radio<String>(
                            value: 'Female',
                            groupValue: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          const Text('Female'),
                          Radio<String>(
                            value: 'Other',
                            groupValue: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                          const Text('Other'),
                        ],
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _symbolController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Symbol Number',
                          prefixIcon: Icon(Icons.numbers),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Symbol Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Phone Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _guardianController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Guardian Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Guardian Phone Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email';
                          }
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9][a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5.0),
                      const Text(
                        'Upload Profile Picture:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                            onPressed: () => _pickImage(ImageSource.camera, true),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.image),
                            label: const Text('Gallery'),
                            onPressed: () => _pickImage(ImageSource.gallery, true),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _profileImage != null
                          ? Image.file(
                        _profileImage!,
                        height: 100,
                      )
                          : const Text('No image selected', style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic),),
                      const SizedBox(height: 10),
                      const Text(
                        'Upload Academic Document SEE:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                            onPressed: () =>
                                _pickImage(ImageSource.camera, false),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.file_upload),
                            label: const Text('File'),
                            onPressed: () =>
                                _pickImage(ImageSource.gallery, false),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _academicDocument != null
                          ? Image.file(
                        _academicDocument!,
                        height: 100,
                      )
                          : const Text('No document selected', style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic),),
                      const SizedBox(height: 10),
                      const Text(
                        'Upload Additional Document +2:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera'),
                            onPressed: () => _pickImage(ImageSource.camera, false, true),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.file_upload),
                            label: const Text('File'),
                            onPressed: () => _pickImage(ImageSource.gallery, false, true),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _document1 != null
                          ? Image.file(
                        _document1!,
                        height: 100,
                      )
                          : const Text('No document selected', style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic),),


                      const SizedBox(height: 5.0),
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                        onPressed: _registerUserAndCreateFirestoreDocument,
                        child: const Text('SUBMIT',style: TextStyle(color: Colors.green),),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      signin(data: model)),
                            );
                          },
                          child: const Text(
                            "Already have an Account, Back To Sign In >>",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
