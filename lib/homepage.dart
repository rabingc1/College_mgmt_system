import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internship/model.dart';
import 'package:internship/pages/academicInfo.dart';
import 'package:internship/pages/assignment.dart';
import 'package:internship/pages/assignment_submit_page/Assignment_submit_page.dart';
import 'package:internship/pages/chat_bot.dart';
import 'package:internship/pages/chatpage.dart';
import 'package:internship/pages/event.dart';
import 'package:internship/pages/faculty.dart';
import 'package:internship/pages/more.dart';
import 'package:internship/pages/result.dart';
import 'package:flutter/material.dart';
import 'BannerSlider.dart';
import 'admin_pannel/admin_pages/chattigpage.dart';
import 'exit_dialog_box_controller.dart';
import 'login_pages/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class homepage extends StatefulWidget {
  const homepage({super.key, required List<imageModel> data});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  late User _user;
  late Stream<DocumentSnapshot> _userStream;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(color: Colors.white, Icons.chat),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => ChatPage(),
              );
            },
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) => ExitConfirmationDialoghomepage(),
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                width: 500,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(90),
                  ),
                ),
                child: StreamBuilder<DocumentSnapshot>(
                  stream: _userStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.data() == null) {
                      return Center(child: Text('User data not found'));
                    }

                    String userName = snapshot.data!.get('name') ?? 'Unknown';
                    String profileImage = snapshot.data!.get('profileImage') ?? '';

                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: profileImage.isNotEmpty
                              ? NetworkImage(profileImage)
                              : null,
                          child: profileImage.isEmpty
                              ? const Icon(Icons.account_circle, size: 50)
                              : null,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              snapshot.data!.get('symbolNumber') ?? 'N/A',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Tribhuvan University",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              snapshot.data!.get('semester') ?? 'N/A',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              // This is for title page
              Container(
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/academicinfo');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(height: 60, color: Colors.green, model[0].image),
                            const Text(
                              "Academic Info",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Assignment_submit_page()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(height: 60, color: Colors.green, model[1].image),
                            const Text(
                              "Assignment",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EventPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(height: 60, color: Colors.green, model[2].image),
                            const Text(
                              "Event",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => fetchdata()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(height: 60, color: Colors.green, model[6].image),
                            const Text(
                              "Material",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResultSearchPage()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(height: 60, color: Colors.green, model[4].image),
                            const Text(
                              "Result",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => more()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(height: 60, color: Colors.green, model[9].image),
                            const Text(
                              "More",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Notice Board",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('0001').doc('noticeboard').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
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
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
