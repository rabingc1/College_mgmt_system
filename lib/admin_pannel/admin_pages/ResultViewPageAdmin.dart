import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultViewPage extends StatefulWidget {
  @override
  _ResultViewPageState createState() => _ResultViewPageState();
}

class _ResultViewPageState extends State<ResultViewPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _showDetails = false;

  void _editResult(DocumentSnapshot result) {
    // Implement edit functionality here
  }

  void _deleteResult(DocumentSnapshot result) async {
    await _firestore.collection('students').doc(result.id).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Result deleted for symbol number: ${result.id}'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Results'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ResultSearchDelegate(_firestore),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('students').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final results = snapshot.data!.docs
                .where((result) => result.id.contains(_searchQuery))
                .toList();

            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                var result = results[index];
                var subjects = result['subjects'] as Map<String, dynamic>;
                var subjectScores = subjects.entries
                    .map((entry) => '${entry.key}: ${entry.value}')
                    .join('\n');

                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: ListTile(
                      title: Text(
                        result['fullName'],
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Symbol Number: ${result.id}\nFaculty: ${result['faculty']}\nSemester: ${result['semester']}\nGPA: ${result['GPA']}\n\nSubjects:\n$subjectScores',
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'edit') {
                            _editResult(result);
                          } else if (value == 'delete') {
                            _deleteResult(result);
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Edit', 'Delete'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice.toLowerCase(),
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                      onTap: () {
                        // Optional: navigate to detailed result view if needed
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ResultSearchDelegate extends SearchDelegate<String> {
  final FirebaseFirestore _firestore;

  ResultSearchDelegate(this._firestore);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final results = snapshot.data!.docs
            .where((result) => result.id.contains(query))
            .toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            var result = results[index];
            var subjects = result['subjects'] as Map<String, dynamic>;
            var subjectScores = subjects.entries
                .map((entry) => '${entry.key}: ${entry.value}')
                .join('\n');

            return AnimatedContainer(
              duration: Duration(milliseconds: 100),
              curve: Curves.easeOutExpo,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.greenAccent, Colors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: ListTile(
                  title: Text(
                    result['fullName'],
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Symbol Number: ${result.id}\nFaculty: ${result['faculty']}\nSemester: ${result['semester']}\nGPA: ${result['GPA']}\n\nSubjects:\n$subjectScores',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        // Implement edit functionality
                      } else if (value == 'delete') {
                        _firestore.collection('students').doc(result.id).delete();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Result deleted for symbol number: ${result.id}'),
                        ));
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'Edit', 'Delete'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice.toLowerCase(),
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                  onTap: () {
                    // Navigate to detailed result view if needed
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('students').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final results = snapshot.data!.docs
            .where((result) => result.id.contains(query))
            .toList();

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            var result = results[index];
            return ListTile(
              title: Text(result['fullName']),
              subtitle: Text('Symbol Number: ${result.id}'),
              onTap: () {
                query = result.id;
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
