import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultSearchPage extends StatefulWidget {
  @override
  _ResultSearchPageState createState() => _ResultSearchPageState();
}

class _ResultSearchPageState extends State<ResultSearchPage> {
  final TextEditingController _symbolNumberController = TextEditingController();
  Map<String, dynamic>? _resultData;
  bool _isLoading = false;

  Future<void> _fetchResult() async {
    setState(() {
      _isLoading = true;
      _resultData = null;
    });

    try {
      String symbolNumber = _symbolNumberController.text.trim();
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('students')
          .doc(symbolNumber)
          .get();

      if (doc.exists) {
        setState(() {
          _resultData = doc.data() as Map<String, dynamic>?;
        });
      } else {
        setState(() {
          _resultData = null;
        });
      }
    } catch (e) {
      print('Error fetching result: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _symbolNumberController,
              decoration: InputDecoration(
                labelText: 'Enter Symbol Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchResult,
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_resultData != null)
              ResultDisplay(resultData: _resultData!)
            else if (_resultData == null && _symbolNumberController.text.isNotEmpty)
                Text('No results found for the entered symbol number.'),
          ],
        ),
      ),
    );
  }
}



class ResultDisplay extends StatelessWidget {
  final Map<String, dynamic> resultData;

  ResultDisplay({required this.resultData});

  String calculateGrade(double percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B+';
    if (percentage >= 60) return 'B';
    if (percentage >= 50) return 'C+';
    return 'Fail';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> subjects = resultData['subjects'] as Map<String, dynamic>;
    double totalMarks = 500.0; // Fixed total marks
    double totalObtainedMarks = 0;
    bool hasFailed = false;

    List<Widget> subjectWidgets = [];
    subjects.forEach((subject, marks) {
      double marksValue = marks?.toDouble() ?? 0.0;
      totalObtainedMarks += marksValue;

      // Check if individual subject marks are below 50
      if (marksValue < 50) {
        hasFailed = true;
      }

      subjectWidgets.add(
        ListTile(
          title: Text(subject),
          trailing: Text(marksValue.toString()),
        ),
      );
    });

    // Calculate percentage
    double percentage = totalMarks > 0 ? (totalObtainedMarks / totalMarks) * 100 : 0;
    String grade = hasFailed ? 'Fail' : calculateGrade(percentage);

    return Expanded(
      child: Card(
        child: ListView(
          children: [
            ListTile(
              title: Text('Full Name'),
              subtitle: Text(resultData['fullName'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Faculty'),
              subtitle: Text(resultData['faculty'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Semester'),
              subtitle: Text(resultData['semester'] ?? 'N/A'),
            ),
            Divider(),
            ...subjectWidgets,
            Divider(),
            ListTile(
              title: Text('Total FM'),
              trailing: Text(totalMarks.toStringAsFixed(2)),
            ),
            ListTile(
              title: Text('Obtained Marks'),
              trailing: Text(totalObtainedMarks.toStringAsFixed(2)),
            ),
            ListTile(
              title: Text('Percentage'),
              trailing: Text(percentage.toStringAsFixed(2)),
            ),
            ListTile(
              title: Text('Grade'),
              trailing: Text(grade),
            ),
          ],
        ),
      ),
    );
  }
}

