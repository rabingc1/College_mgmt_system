import 'package:internship/homepage.dart';
import 'package:internship/pages/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship/pages/setting.dart';

import '../model.dart';
import '../settingpage/AttendanceSessionScreen.dart';
import '../settingpage/form.dart';
import 'academicInfo.dart';
import 'assignment.dart';
import 'event.dart';
import 'faculty.dart';

class more extends StatelessWidget {
  const more({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
      ),
      body: Container(
        child: Column(
          children:<Widget> [

            Container(
              height: 400,
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
                        MaterialPageRoute(builder: (context) => AcademicInfoPage()),
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
                        MaterialPageRoute(builder: (context) => result()),
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
                        MaterialPageRoute(builder: (context) => const EventPage()),
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
                        MaterialPageRoute(builder: (context) => fetchdata()),
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
                        MaterialPageRoute(builder: (context) => AttendanceSessionScreen()),
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
                              height: 60, color: Colors.green, model[10].image),
                          Text(
                            "Attendance",
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
                        MaterialPageRoute(builder: (context) => const setting()),
                      );
                    },
                    child: Container(// this is for setting--------------------------------------------------------------------------------------
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
                              height: 60, color: Colors.green, model[11].image),
                          Text(
                            "Setting",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      )


    );
  }
}
