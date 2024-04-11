

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship/homepage.dart';
import 'package:internship/login_pages/sign_in.dart';
import 'package:internship/model.dart';

import '../settingpage/User_information.dart';
import '../settingpage/support_page.dart';
import '../settingpage/terms_and_condition.dart';
import 'ProfilePage.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  late User _user; // Firebase user object
  late Stream<DocumentSnapshot> _userStream;




  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!; // Get current authenticated user
    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .snapshots(); // Firestore stream for user document
  }


  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: Text("Setting"),

  ),
  body:   StreamBuilder<DocumentSnapshot>(
      stream: _userStream,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      if (!snapshot.hasData || snapshot.data!.data() == null) {
        return Center(child: Text('No data available'));
      }

      // Retrieve user data from Firestore document
      Map<String, dynamic> userData = snapshot.data!.data() as Map<
          String,
          dynamic>;
      String name = userData['name'] ?? '';
      String email = userData['email'] ?? '';
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
              scrollDirection: Axis.vertical,
              children: [

                SizedBox(
                  height: 180,
                  child: DrawerHeader(
                    margin: EdgeInsets.all(0.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(model[12].image),
                          fit: BoxFit.cover),
                    ),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 48,

                          child: Stack(
                              children: [
                                CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.white70,
                                    child:
                                  Text("dd")/*IconButton(
                                      iconSize: 72,
                                      icon: const Icon(Icons.favorite), onPressed: () {
                                        Navigator.push(context, route)
                                    },

                                    ),*/
                                ),


                              ]
                          ),
                        ),

                        Container(
                  height: 10,
                        ),

                         Text(
                        ' $name',style: TextStyle(fontSize: 20,color: Colors.black),
                      ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                    leading: const Icon(
                      Icons.supervised_user_circle_sharp,
                      size: 35,

                    ),
                    title: Text("Profile", style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            ProfilePage( userId: '',)),
                      );
                    }
                ),

                ListTile(
                    leading: const Icon(
                      Icons.perm_device_information,
                      size: 35,

                    ),
                    title: Text(
                      "Information", style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>

                          userinformation()),
                      );
                    }
                ),
                ListTile(
                    leading: const Icon(
                      Icons.rule,
                      size: 35,

                    ),
                    title: const Text(
                      "Terms & Conditions", style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            termsandcondition()),
                      );
                    }
                ),
                ListTile(
                    leading: Icon(
                      Icons.headphones,
                      size: 35,

                    ),
                    title: Text("Support", style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                        suport_page()),
                      );
                    }
                ),
                ListTile(

                    leading: Icon(
                      Icons.question_mark,
                      size: 35,

                    ),
                    title: Text("Help", style: TextStyle(fontSize: 20,),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            homepage(data: model)),
                      );
                    }
                ),
                ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      size: 35,

                    ),
                    title: Text("LogOut", style: TextStyle(fontSize: 20),),
                  onTap: (){
                      showDialog(context: context, builder: (context)=>AlertDialog(
                        title: Text("LogOut"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("No")),
                          TextButton(
                            onPressed: () {
                              // Perform logout action and navigate to SignInPage
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => signin(data: model)),
                              );
                            },
                            child: Text("Yes"),
                          ),

                        ],
                      ));
                  },

                ),
              ]),
        ),
      );


    }
  ),

    );

  }




}
