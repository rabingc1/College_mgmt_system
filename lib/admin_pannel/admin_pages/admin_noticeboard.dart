import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AdminNoticeboard extends StatefulWidget {
  const AdminNoticeboard({Key? key}) : super(key: key);

  @override
  _AdminNoticeboardState createState() => _AdminNoticeboardState();
}

class _AdminNoticeboardState extends State<AdminNoticeboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _newNoticeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Noticeboard'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notice Board",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('0001')
                    .doc('noticeboard')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.data() == null) {
                    return Text('No data available');
                  }

                  String textData = (snapshot.data!.data() as Map<String, dynamic>)['todays notice'] ?? 'No text found';

                  return Text(
                    textData,
                    style: TextStyle(fontSize: 15, color: Colors.green),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Update Notice",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            TextField(
              controller: _newNoticeController,
              decoration: InputDecoration(
                hintText: 'Enter new notice',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _updateNotice(_newNoticeController.text);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateNotice(String newNotice) async {
    try {
      await _firestore.collection('0001').doc('noticeboard').update({
        'todays notice': newNotice,
      });
      _newNoticeController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notice updated successfully!'),
        ),
      );
    } catch (e) {
      print('Error updating notice: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update notice. Please try again later.'),
        ),
      );
    }
  }
}
