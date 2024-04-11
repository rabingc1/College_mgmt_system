import 'package:internship/login_pages/sign_in.dart';
import 'package:internship/login_pages/sign_up.dart';
import 'package:internship/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'user_registered.dart';

class Signinandsignupmain extends StatelessWidget {
  final List<imageModel> data;
  const Signinandsignupmain({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text(""),),
        body:
            /* Container(
          width: MediaQuery.of(context).size.width , // 80% of screen width
          height: MediaQuery.of(context).size.height * 1.5,

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(model[3].image,fit: BoxFit.cover,

                ),
                Text("log in ")

              ],
            ),
          ),
        )*/

            Container(
      width: MediaQuery.of(context).size.width, // 80% of screen width
      height: 900, // MediaQuery.of(context).size.height, // 80% of screen width

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            model[7].image,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SafeArea(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 65, top: 400, bottom: 0),
                  child: Column(
                    children: [
                      Text(
                        "Welcome To ",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      Text(
                        "College Management System",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      Text(
                        "To Enroll",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,decoration: TextDecoration.underline,
                            color: Colors.green),
                      ),
                      Text(
                        "Please Sign In To Your Account",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,decoration: TextDecoration.underline,
                            color: Colors.green),
                      ),
                      Container(
                        height: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  // Navigate to the new page route when tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signin(
                                              data: [],
                                            )),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      "Sign In",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Icon(Icons.arrow_circle_right_rounded)
                                  ],
                                )),
                            Text("  "),
                            ElevatedButton(
                                onPressed: () {
                                  // Navigate to the new page route when tapped
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Userregistration(data: [],)),
                                  );
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      "Sign Up",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Icon(Icons.arrow_circle_right_rounded)
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));

    /*ListView.builder(
        itemCount: model.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Column(
              children: [
                Image.asset(
                  model[3].image,

                ),

              ],
            ),
          );
        }
      )*/
  }

  // Foreground widget her
}
