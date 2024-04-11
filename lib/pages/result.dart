import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internship/pages/setting.dart';

class result extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<result> {
  late User _user; // Firebase user object
  late Stream<QuerySnapshot<Map<String, dynamic>>> _resultStream; // Firestore collection stream

  @override
  void initState() {
    super.initState();
    _initializeUser(); // Initialize Firebase user
  }

  Future<void> _initializeUser() async {
    _user = FirebaseAuth.instance.currentUser!;
    if (_user != null) {
      _resultStream = FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .collection('result')
          .snapshots();
    } else {
      // Handle authentication issue (user not logged in)
      // For example, navigate to login screen
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Results'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _resultStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available'));
          }

          // Retrieve result data from Firestore documents
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot<Map<String, dynamic>> document = snapshot.data!.docs[index];
              Map<String, dynamic>? resultData = document.data();

              if (resultData == null) {
                return SizedBox(); // Handle case where resultData is null
              }

              String subject = resultData['semester'] ?? 'N/A'; // Use default value if 'subject' is null
              dynamic? score = resultData['cgpa'] as dynamic?; // Use int? to allow for null 'score'

              return Card(

                shadowColor: Colors.red,
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: GestureDetector(
                  onTap:(){
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 150,
                          color: Colors.black,
                          child: Column(
                            children: [
                              Container(

                                padding: EdgeInsets.only(left: 350,top: 0,bottom: 0),
                                child: IconButton(
                                iconSize: 40,
                                  color: Colors.white,
                                  onPressed: () => Navigator.pop(context),  icon: new Icon(Icons.cancel_outlined),),
                              ),
                              Center(child: const Text('Sorry!! Grade Sheet is not avaiable ',style: TextStyle(color: Colors.white),)),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    iconColor: Colors.green,
                    title: Text('Semester: $subject', style: TextStyle(fontSize: 18)),
                    subtitle: Text('CGPA: ${score ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                    trailing: const Column(
                        children: <Widget>[
                          Icon(Icons.file_copy_rounded),

                        ]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
