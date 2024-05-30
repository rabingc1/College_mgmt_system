import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewNewAssignment extends StatefulWidget {
  const ViewNewAssignment({super.key});

  @override
  State<ViewNewAssignment> createState() => _ViewNewAssignmentState();
}

class _ViewNewAssignmentState extends State<ViewNewAssignment> {
  List<Map<String, dynamic>> files = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFiles();
  }

  Future<void> fetchFiles() async {
    final storageRef = FirebaseStorage.instance.ref().child('Assignment');
    final ListResult result = await storageRef.listAll();

    final List<Map<String, dynamic>> fetchedFiles = [];
    for (var ref in result.items) {
      final String url = await ref.getDownloadURL();
      final FullMetadata meta = await ref.getMetadata();
      fetchedFiles.add({
        'name': ref.name,
        'url': url,
        'size': meta.size,
      });
    }

    setState(() {
      files = fetchedFiles;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Assignments'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
          return ListTile(
            title: Text(file['name']),
            subtitle: Text('Size: ${file['size']} bytes'),
            trailing: ElevatedButton(
              onPressed: () => _openFile(file['url']),
              child: Text('View'),
            ),
          );
        },
      ),
    );
  }

  void _openFile(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
