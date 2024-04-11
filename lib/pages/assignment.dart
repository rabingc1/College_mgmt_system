import 'dart:async';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/material.dart';

// Define the file path and name
String file = "/Assignment/sumin.pdf";
String fileName = "AI cover sumin.pdf";

class LoadFirebaseStoragePdf extends StatefulWidget {
  @override
  _LoadFirebaseStoragePdfState createState() => _LoadFirebaseStoragePdfState();
}

class _LoadFirebaseStoragePdfState extends State<LoadFirebaseStoragePdf> {
  String _pathPDF = "";
  String _pdfUrl = "";

  @override
  void initState() {
    super.initState();
    // Fetch file from Firebase Storage
    _loadPdfFromFirebase();
  }

  Future<void> _loadPdfFromFirebase() async {
    try {
      // Fetch PDF file URL from Firebase Storage
      String url = await _loadFromFirebase(file);

      // Create PDF file locally from URL
      File pdfFile = await _createFileFromPdfUrl(url);

      setState(() {
        // Set local path to the PDF file
        _pathPDF = pdfFile.path;
      });
    } catch (e) {
      print("Error loading PDF: $e");
      // Handle error (e.g., show error message)
    }
  }

  Future<String> _loadFromFirebase(String url) {
    // Simulate loading from Firebase Storage
    // Replace this with actual Firebase Storage implementation
    return Future.value("https://example.com/pdf");
  }

  Future<File> _createFileFromPdfUrl(String url) async {
    // Simulate creating a file from URL
    // Replace this with actual file creation logic
    return File('path/to/local/pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _openPdf();
              },
              child: Text(
                "Open PDF",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openPdf() {
    // Implement PDF opening logic here
    if (_pathPDF.isNotEmpty) {
      // Open the PDF using platform-specific implementation
      _launchPDF(context, fileName, _pathPDF, _pdfUrl);
    } else {
      // Handle case where PDF path is empty (file not loaded)
      print("PDF file not loaded.");
      // Show an error message or take appropriate action
    }
  }

  void _launchPDF(BuildContext context, String title, String pdfPath, String pdfUrl) {
    // Platform-specific implementation to open the PDF
    // Replace this with actual implementation based on platform
    print("Opening PDF: $pdfPath");
    // Implement logic to open PDF file based on platform (iOS, Android, Web)
  }
}

void main() {
  runApp(MaterialApp(
    home: LoadFirebaseStoragePdf(),
  ));
}
