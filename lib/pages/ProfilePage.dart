import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  bool _uploading = false;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchProfileImage();
  }

  Future<void> _fetchProfileImage() async {
    try {
      // Retrieve user document from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      // Get profile image URL from user document
      if (userDoc.exists) {
        setState(() {
          _profileImageUrl = userDoc.data()?['profileImageUrl'];
        });
      }
    } catch (e) {
      print('Error fetching profile image: $e');
    }
  }

  Future<void> _uploadImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _uploading = true;
      });

      try {
        // Upload image to Firebase Storage
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('profile_images/$fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile!);
        TaskSnapshot taskSnapshot = await uploadTask;

        if (taskSnapshot.state == TaskState.success) {
          // Get download URL of uploaded image
          final imageUrl = await taskSnapshot.ref.getDownloadURL();

          // Update user document in Firestore with image URL
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.userId)
              .update({'profileImageUrl': imageUrl});

          setState(() {
            _profileImageUrl = imageUrl; // Update profile image URL
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile picture uploaded successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          throw 'Image upload failed';
        }
      } catch (e) {
        print('Image upload error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload profile picture'),
            duration: Duration(seconds: 5),
          ),
        );
      } finally {
        setState(() {
          _uploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          /*  CircleAvatar(
              radius: 80,
              backgroundImage: _profileImageUrl != null
                  ? NetworkImage(_profileImageUrl!)
                  : (_imageFile != null ? FileImage(_imageFile!) : null),
              child: (_profileImageUrl == null && _imageFile == null)
                  ? Icon(Icons.person, size: 80)
                  : null,
            ),*/
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _uploading ? null : () => _uploadImage(ImageSource.gallery),
              child: _uploading ? CircularProgressIndicator() : Text('Upload from Gallery'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploading ? null : () => _uploadImage(ImageSource.camera),
              child: _uploading ? CircularProgressIndicator() : Text('Take a Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
