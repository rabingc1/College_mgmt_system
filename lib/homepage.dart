import 'package:internship/model.dart';
import 'package:internship/pages/academicInfo.dart';
import 'package:internship/pages/assignment.dart';
import 'package:internship/pages/event.dart';
import 'package:internship/pages/faculty.dart';
import 'package:internship/pages/more.dart';
import 'package:internship/pages/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'exit_dialog_box_controller.dart';
import 'login_pages/sign_in.dart';
import 'model.dart';

class homepage extends StatelessWidget {
  const homepage({super.key, required List<imageModel> data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (context) => ExitConfirmationDialoghomepage(),
          );
        },
        child: Column(children: [
          Container(
              height: 150,
              width: 500,
              // width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue, // Example color
                borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(
                        90)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.account_circle,
                          size: 50,
                        ),
                      ),




                      Container(
                        width: 200,
                        child: const Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "  Ram",
                                  style: TextStyle(color: Colors.white),
                                )),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("  BCA 7th Semester",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("  Tribhuvan University",
                                  style: TextStyle(color: Colors.white)),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("  0000120",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              )),//This is for titel page
          Container(    //this is for Academic Information----------------------------------------------------------
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
                       // Navigate to the new page route when tapped
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => academicinfo()),
                       );
                     },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset:
                                const Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(height: 60,color: Colors.green, model[0].image),
                          const Text(
                            "Academic info",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),//this is for Academic Information
                  GestureDetector(
                    onTap: () {
                      // Navigate to the new page route when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => assignment()),
                      );
                    },
                    child: Container(// this is for Assignment---------------------------------------------------------------------------------
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(height: 60,color: Colors.green, model[1].image),
                          const Text(
                            "Assignment",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),// this is for Assignment
                   GestureDetector(
                    onTap: () {
                      // Navigate to the new page route when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => event()),
                      );
                    },
                    child: Container(// this is fro event--------------------------------------------------------
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                              height: 60, color: Colors.green, model[2].image),
                          const Text(
                            "Event",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ), // this is fro event
                   GestureDetector(
                     onTap: () {
                       // Navigate to the new page route when tapped
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => faculty()),
                       );
                     },
                    child: Container(// this is for Faculty---------------------------------------------------------------------------------------
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
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
                          Image.asset(height: 60,color: Colors.green, model[6].image),
                          Text(
                            "Faculty",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ), // this is for Faculty
                   GestureDetector(
                     onTap: () {
                       // Navigate to the new page route when tapped
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => result()),
                       );
                     },
                    child: Container(// this is for Result--------------------------------------------------------------------------------------
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
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
                          Image.asset(
                              height: 60, color: Colors.green, model[4].image),
                          Text(
                            "Result",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the new page route when tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => more()),
                      );
                    },
                    child: Container(// this is for Result--------------------------------------------------------------------------------------
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
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
                          Image.asset(
                              height: 60, color: Colors.green, model[9].image),
                          Text(
                            "More",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),// this is for Result
                ],
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            padding: const
            EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              /*    boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 5), // changes position of shadow
                  ),
                ],*/
            ),
            child: Column(
              children: [
                Text(
                  "Notice Board",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 20),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Center(child: Text("Today's notice here")),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
/*
Image.asset(
height: 40,

model[2].image),
Text(model[index].Name)*/
