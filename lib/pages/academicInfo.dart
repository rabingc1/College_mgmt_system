/*
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
}*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AcademicInfoPage extends StatefulWidget {
  const AcademicInfoPage({super.key});

  @override
  State<AcademicInfoPage> createState() => _AcademicInfoPageState();
}

class _AcademicInfoPageState extends State<AcademicInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Academic Info"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              DataTable(
                columns: const [
                  DataColumn(label: Text('Subject Code')),
                  DataColumn(label: Text('Subject Name')),
                  DataColumn(label: Text('Credit Hours')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('CSC101')),
                    DataCell(Text('Introduction to Programming')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('MTH101')),
                    DataCell(Text('Calculus I')),
                    DataCell(Text('4')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('PHY101')),
                    DataCell(Text('Physics I')),
                    DataCell(Text('4')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('ENG101')),
                    DataCell(Text('English Composition')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('HIS101')),
                    DataCell(Text('World History')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('CSC102')),
                    DataCell(Text('Computer Science Seminar')),
                    DataCell(Text('1')),
                  ]),
                ],
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Subject Code')),
                  DataColumn(label: Text('Subject Name')),
                  DataColumn(label: Text('Credit Hours')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('CSC101')),
                    DataCell(Text('Introduction to Programming')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('MTH101')),
                    DataCell(Text('Calculus I')),
                    DataCell(Text('4')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('PHY101')),
                    DataCell(Text('Physics I')),
                    DataCell(Text('4')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('ENG101')),
                    DataCell(Text('English Composition')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('HIS101')),
                    DataCell(Text('World History')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('CSC102')),
                    DataCell(Text('Computer Science Seminar')),
                    DataCell(Text('1')),
                  ]),
                ],
              ),
              DataTable(
                columns: const [
                  DataColumn(label: Text('Subject Code')),
                  DataColumn(label: Text('Subject Name')),
                  DataColumn(label: Text('Credit Hours')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('CSC101')),
                    DataCell(Text('Introduction to Programming')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('MTH101')),
                    DataCell(Text('Calculus I')),
                    DataCell(Text('4')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('PHY101')),
                    DataCell(Text('Physics I')),
                    DataCell(Text('4')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('ENG101')),
                    DataCell(Text('English Composition')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('HIS101')),
                    DataCell(Text('World History')),
                    DataCell(Text('3')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('CSC102')),
                    DataCell(Text('Computer Science Seminar')),
                    DataCell(Text('1')),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),

    );

  }
}
