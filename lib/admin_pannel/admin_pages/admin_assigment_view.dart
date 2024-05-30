import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class AssignmentView extends StatefulWidget {
  @override
  _AssignmentViewState createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<Map<String, dynamic>> _files = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  Future<void> _loadAssignments() async {
    try {
      final ListResult result = await _storage.ref('Assignment').listAll();
      final List<Map<String, dynamic>> files = [];

      if (result.items.isEmpty) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'No assignments found in the "Assignments" folder.';
        });
        return;
      }

      for (var ref in result.items) {
        final String url = await ref.getDownloadURL();
        final FullMetadata metadata = await ref.getMetadata();
        files.add({
          'name': metadata.name,
          'url': url,
          'size': metadata.size,
        });
      }

      setState(() {
        _files = files;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading assignments: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading assignments: $e';
      });
    }
  }

  Future<void> _downloadFile(String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      await Dio().download(url, filePath);
      print('File downloaded to $filePath');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Downloaded $fileName to $filePath'),
      ));
      OpenFile.open(filePath);
    } catch (e) {
      print('Error downloading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error downloading file: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignment View'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : ListView.builder(
        itemCount: _files.length,
        itemBuilder: (context, index) {
          final file = _files[index];
          return Card(
            child: ListTile(
              title: Text(file['name'] ?? 'No Name'),
              subtitle: Text('Size: ${file['size']} bytes'),
              trailing: IconButton(
                icon: Icon(Icons.download),
                onPressed: () {
                  _downloadFile(file['url'], file['name']);
                },
              ),
              onTap: () {
                _openFile(file['url']);
              },
            ),
          );
        },
      ),
    );
  }

  void _openFile(String url) {
    print('Opening file: $url');
    // Use url_launcher or any other method to open the file
  }
}
