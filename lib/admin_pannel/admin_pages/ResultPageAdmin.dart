import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ResultViewPageAdmin.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _symbolNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _selectedFaculty;
  String? _selectedSemester;

  Map<String, Map<String, List<String>>> _subjects = {
    'BCA': {
      '1': ['Mathematics I', 'Digital Logic', 'Introduction to IT', 'C Programming', 'Society and Technology'],
      '2': ['Mathematics II', 'Microprocessor and Computer Architecture', 'Discrete Structures', 'Data Structures and Algorithms', 'Probability and Statistics'],
      '3': ['Mathematics III', 'Computer Graphics', 'Object-Oriented Programming', 'Computer Networks', 'Operating Systems'],
      '4': ['Software Engineering', 'Database Management Systems', 'Artificial Intelligence', 'Web Technology I', 'Numerical Methods'],
      '5': ['Web Technology II', 'Mobile Application Development', 'System Analysis and Design', 'E-Governance', 'Multimedia Computing'],
      '6': ['Network Programming', 'Advanced Java', 'Mobile Programming', 'Distributed Systems', 'Applied Economics'],
      '7': ['Internship', 'Artificial Intelligence', 'Advanced Database', 'Cloud Computing', 'Cyber Law'],
      '8': ['Operational Research', 'Data Analysis', 'Multimedia'],
    },
    'BBM': {
      '1': ['Business Mathematics I', 'English I', 'Principles of Management', 'Financial Accounting', 'Computer System and IT Applications'],
      '2': ['Business Mathematics II', 'English II', 'Sociology for Business', 'Macro Economics', 'Cost and Management Accounting'],
      '3': ['Business Statistics', 'Business Communication', 'Psychology for Business', 'Micro Economics', 'Financial Management'],
      '4': ['Business Research Methods', 'Legal Environment of Business', 'Essentials of Finance', 'Human Resource Management', 'Fundamentals of Marketing'],
      '5': ['Organizational Behavior', 'International Business', 'Taxation in Nepal', 'Operations Management', 'Elective I'],
      '6': ['Business Environment in Nepal', 'Project Management', 'Banking and Insurance', 'Business Ethics and Social Responsibility', 'Elective II'],
      '7': ['Entrepreneurship and Small Business Management', 'Management of Information Systems', 'Tourism and Hospitality Management', 'Strategic Management', 'Elective III'],
      '8': ['Project Report', 'Corporate Finance', 'Investment Management', 'Risk and Insurance Management', 'Consumer Behavior', 'Sales Management', 'Retail Management', 'Labor Relations', 'Compensation Management', 'International Human Resource Management'],
    },
    'BIM': {
      '1': ['English I', 'Mathematics I', 'Introduction to Information Systems', 'Fundamentals of Programming', 'Principles of Management'],
      '2': ['English II', 'Mathematics II', 'Database Management Systems', 'Computer Organization and Architecture', 'Microeconomics'],
      '3': ['Statistics for Management', 'Object-Oriented Programming', 'Data Structures and Algorithms', 'Business Communication', 'Managerial Economics'],
      '4': ['Software Engineering', 'Operating Systems', 'Business Process Management', 'Human Resource Management', 'Financial Accounting'],
      '5': ['Web Technologies', 'Networking and Data Communication', 'Project Management', 'Information Systems Management', 'Research Methods'],
      '6': ['E-Commerce', 'System Analysis and Design', 'Information Security', 'Business Intelligence', 'Elective I'],
      '7': ['Enterprise Resource Planning (ERP)', 'Information Systems Audit', 'Information Systems Development', 'Elective II', 'Elective III'],
      '8': ['Consumer Behavior', 'Sales Management', 'Retail Management', 'Labor Relations'],
    },
  };

  List<TextEditingController> _subjectControllers = [];
  List<String> _currentSubjects = [];

  void _generateSubjectFields() {
    if (_selectedFaculty != null && _selectedSemester != null) {
      setState(() {
        _subjectControllers.clear();
        _currentSubjects.clear();
        if (_subjects.containsKey(_selectedFaculty) &&
            _subjects[_selectedFaculty]!.containsKey(_selectedSemester)) {
          _currentSubjects = _subjects[_selectedFaculty]![_selectedSemester]!;
          for (String subject in _currentSubjects) {
            _subjectControllers.add(TextEditingController());
          }
        }
      });
    }
  }

  void _updateResult() async {
    if (_formKey.currentState!.validate()) {
      String symbolNumber = _symbolNumberController.text;
      String fullName = _fullNameController.text;
      String faculty = _selectedFaculty!;
      String semester = _selectedSemester!;

      Map<String, int> subjects = {};
      int totalMarks = 0;

      for (int i = 0; i < _subjectControllers.length; i++) {
        String subject = _currentSubjects[i];
        int score = int.parse(_subjectControllers[i].text);
        subjects[subject] = score;
        totalMarks += score;
      }

      double gpa = totalMarks / _subjectControllers.length;  // Example GPA calculation

      await _firestore.collection('students').doc(symbolNumber).set({
        'fullName': fullName,
        'faculty': faculty,
        'semester': semester,
        'subjects': subjects,
        'totalMarks': totalMarks,
        'GPA': gpa,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Result updated for symbol number: $symbolNumber'),
      ));
    }
  }

  @override
  void dispose() {
    _symbolNumberController.dispose();
    _fullNameController.dispose();
    for (var controller in _subjectControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 5.0),
                TextFormField(
                  controller: _symbolNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Symbol Number',
                    prefixIcon: Icon(Icons.location_on),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter symbol number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.location_on),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: _selectedFaculty,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Faculty',
                    prefixIcon: Icon(Icons.location_on),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                  ),
                  items: _subjects.keys.map((String faculty) {
                    return DropdownMenuItem<String>(
                      value: faculty,
                      child: Text(faculty),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFaculty = newValue;
                      _selectedSemester = null;  // Reset semester when faculty changes
                      _subjectControllers.clear();
                      _currentSubjects.clear();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a faculty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15.0),
                DropdownButtonFormField<String>(
                  value: _selectedSemester,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Semester'),
                  items: _selectedFaculty != null
                      ? _subjects[_selectedFaculty]!.keys.map((String semester) {
                    return DropdownMenuItem<String>(
                      value: semester,
                      child: Text(semester),
                    );
                  }).toList()
                      : [],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSemester = newValue;
                      _generateSubjectFields();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a semester';
                    }
                    return null;
                  },
                ),
                ..._subjectControllers.map((controller) {
                  int index = _subjectControllers.indexOf(controller);
                  String subject = _currentSubjects[index];
                  return Card(

                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),

                          labelText: subject,

                      ),

                      keyboardType: TextInputType.number,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter marks for $subject';
                        }
                        return null;
                      },
                    ),
                  );
                }).toList(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateResult,
                  child: Text('Update Result'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultViewPage()),
                    );
                  },
                  child: Text('View Results'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


