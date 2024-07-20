import 'package:flutter/material.dart';

import 'admin_pages/ResultPageAdmin.dart';
import 'admin_pages/admin_assigment_view.dart';
import 'admin_pages/admin_noticeboard.dart';
import 'admin_pages/admin_useraccounts.dart';
import 'admin_pages/chattigpage.dart';
import 'admin_pages/event_update_admin.dart';
import 'admin_pages/upload_asignment_admin.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Admin Panel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildGridItem(
                    context,
                    'Submitted Assignment ',
                    Icons.view_list,
                    Colors.blue,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssignmentView()));
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Upload Assignment',
                    Icons.upload_file,
                    Colors.green,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadAssignmentPage()));
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Notice Board',
                    Icons.notifications,
                    Colors.orange,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminNoticeboard()));
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Upload Notice Board',
                    Icons.upload_rounded,
                    Colors.purple,
                    () {
                      // Navigate to Upload Notice Board page
                      print('Navigate to Upload Notice Board');
                    },
                  ),
                  _buildGridItem(
                    context,
                    'User',
                    Icons.person,
                    Colors.red,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserListPage()));
                      // Navigate to User page
                      print('Navigate to User');
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Result',
                    Icons.assessment,
                    Colors.brown,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultPage()));
                      print('Navigate to Result');
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Chat Box ',
                    Icons.mark_unread_chat_alt_sharp,
                    Colors.blue,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdminChatPage()));
                    },
                  ),
                  _buildGridItem(
                    context,
                    'Event Update ',
                    Icons.event,
                    Colors.blue,
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  EventListPage()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
