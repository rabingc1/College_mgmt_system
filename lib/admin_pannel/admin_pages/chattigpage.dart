import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminChatPage extends StatefulWidget {
  @override
  _AdminChatPageState createState() => _AdminChatPageState();
}

class _AdminChatPageState extends State<AdminChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedUserEmail;

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      await _firestore.collection('chats').add({
        'text': _controller.text,
        'createdAt': Timestamp.now(),
        'userId': _auth.currentUser?.uid,
        'userEmail': selectedUserEmail,
        'senderName': 'Admin',
      });
      _controller.clear();
    }
  }

  void _deleteMessage(String userEmail, Timestamp createdAt) {
    _firestore
        .collection('chats')
        .where('userEmail', isEqualTo: userEmail)
        .where('createdAt', isEqualTo: createdAt)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  void _showDeleteDialog(String userEmail, Timestamp createdAt) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Delete Message'),
        content: Text('Are you sure you want to delete this message?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteMessage(userEmail, createdAt);
              Navigator.of(ctx).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> data) {
    final isAdmin = data['senderName'] == 'Admin';
    final timestamp = (data['createdAt'] as Timestamp).toDate();
    final timeString = "${timestamp.hour}:${timestamp.minute}";

    return GestureDetector(
      onLongPress: () {
        _showDeleteDialog(data['userEmail'], data['createdAt']);
      },
      child: Align(
        alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
        child: Card(
          color: isAdmin ? Colors.blue[100] : Colors.green[100],
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!isAdmin)
                  CircleAvatar(
                    radius: 12,
                    child: Icon(Icons.person),
                  ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment:
                  isAdmin ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['text'],
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      timeString,
                      style: TextStyle(fontSize: 11, color: Colors.black54),
                    ),
                  ],
                ),
                if (isAdmin) SizedBox(width: 10),
                if (isAdmin)
                  CircleAvatar(
                    radius: 12,
                    child: Icon(Icons.person),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserListItem(String userEmail, String lastMessage) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(userEmail),
      subtitle: Text(
        lastMessage,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        setState(() {
          selectedUserEmail = userEmail;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
            selectedUserEmail == null ? 'Admin Chat' : ' $selectedUserEmail'),
        leading: selectedUserEmail == null
            ? null
            : IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selectedUserEmail = null;
            });
          },
        ),
      ),
      body: selectedUserEmail == null
          ? StreamBuilder(
        stream: _firestore.collection('chats').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final users = <String, Map<String, dynamic>>{};

          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final userEmail = data['userEmail'] as String?;
            if (userEmail != null) {
              if (!users.containsKey(userEmail) ||
                  (data['createdAt'] as Timestamp)
                      .toDate()
                      .isAfter((users[userEmail]!['createdAt'] as Timestamp).toDate())) {
                users[userEmail] = data;
              }
            }
          }

          final userList = users.entries.map((entry) {
            final data = entry.value;
            final lastMessage = data['text'] as String;
            return _buildUserListItem(entry.key, lastMessage);
          }).toList();

          return ListView(children: userList);
        },
      )
          : Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('chats')
                  .where('userEmail', isEqualTo: selectedUserEmail)
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return _buildMessageItem(data);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Send a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
