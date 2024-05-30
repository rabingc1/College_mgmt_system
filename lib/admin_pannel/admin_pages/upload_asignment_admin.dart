import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadAssignmentPage extends StatefulWidget {
  @override
  _UploadAssignmentPageState createState() => _UploadAssignmentPageState();
}

class _UploadAssignmentPageState extends State<UploadAssignmentPage> {
  File? _selectedFile;
  bool _isUploading = false;

  Future<void> _uploadAssignment() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a file to upload.')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final storageRef = FirebaseStorage.instance.ref().child('assignments');
      final fileName = _selectedFile!.path.split('/').last;
      await storageRef.child(fileName).putFile(_selectedFile!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Assignment uploaded successfully.')),
      );
    } catch (e) {
      print('Error uploading assignment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading assignment: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _navigateToViewAssignments() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewAssignmentsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Assignment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _isUploading ? null : _selectFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 16),
            _selectedFile != null
                ? Text('File Selected: ${_selectedFile!.path}')
                : Container(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadAssignment,
              child: Text('Upload Assignment'),
            ),
            SizedBox(height: 16),
            _isUploading
                ? Center(child: CircularProgressIndicator())
                : Container(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _navigateToViewAssignments,
              child: Text('View Assignments'),
            ),
          ],
        ),
      ),
    );
  }
}
class ViewAssignmentsPage extends StatefulWidget {
  @override
  _ViewAssignmentsPageState createState() => _ViewAssignmentsPageState();
}

class _ViewAssignmentsPageState extends State<ViewAssignmentsPage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<String> _assignmentUrls = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAssignments();
  }

  Future<void> _fetchAssignments() async {
    try {
      final ListResult result = await _storage.ref('assignments').listAll();

      setState(() {
        _assignmentUrls = result.items.map((item) => item.fullPath).toList();
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching assignments: $e');
    }
  }

  Future<void> _deleteAssignment(String url, String fileName) async {
    try {
      await _storage.ref(url).delete();
      setState(() {
        _assignmentUrls.remove(url);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted $fileName')),
      );
    } catch (e) {
      print('Error deleting assignment: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting $fileName: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Assignments')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _assignmentUrls.length,
        itemBuilder: (context, index) {
          final assignmentUrl = _assignmentUrls[index];
          final fileName = assignmentUrl.split('/').last;
          return ListTile(
            title: Text(fileName),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _deleteAssignment(assignmentUrl, fileName);
                  },
                  child: Text('Delete'),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Implement logic to download or view the assignment
                  },
                  child: Text('Download'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}