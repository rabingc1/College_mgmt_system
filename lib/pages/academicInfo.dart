import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AcademicInfoPage extends StatelessWidget {
  final Map<String, List<String>> semesterSubjects = {
    'Semester 1': ['Digital Logic', 'English', 'Fundamental computer', 'Maths','Society and technology'],
    'Semester 2': ['Mathematics II', 'Account', 'Microprocessor', 'C Programming','English II'],
    'Semester 3': ['Data Structures and Algorithms', 'OPP in Java', 'Probability and statistics', 'SAD','Web Technology'],
    'Semester 4': ['Data Base', 'Numerical Methods  ', 'Operating System', 'Software Engineering ','Scripting Language'],
    // Add more semesters and subjects as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: semesterSubjects.entries.map((entry) {
            return SemesterSection(semester: entry.key, subjects: entry.value);
          }).toList(),
        ),
      ),
    );
  }
}

class SemesterSection extends StatelessWidget {
  final String semester;
  final List<String> subjects;

  SemesterSection({required this.semester, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            semester,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subjects.map((subject) {
              return Text(subject, style: TextStyle(fontSize: 16));
            }).toList(),
          ),
        ],
      ),
    );
  }
}