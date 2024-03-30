import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship/homepage.dart';
import 'package:internship/login_pages/sign_in.dart';
import 'package:internship/model.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: Text("Setting"),

  ),
  body:   Container(
    height: MediaQuery.of(context).size.height,

    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
          scrollDirection: Axis.vertical,
          children:[
            DrawerHeader(
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
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                    AssetImage(model[11].image),

                    backgroundColor: Colors.transparent,
                  ),
                  Container(
                    height: 3,
                  ),
                  Text(
                    'username',style: TextStyle(fontSize: 20,color: Colors.black
                  ),
                  ),
                ],
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.home,
                  size: 35,

                ),
                title: Text("Home", style: TextStyle(fontSize: 20,),),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homepage(data: model)),
                  );
                }
            ),

            ListTile(
                leading: Icon(
                  Icons.app_registration_sharp,
                  size: 35,

                ),
                title: Text("Registration", style: TextStyle(fontSize: 20,),),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homepage(data: model)),
                  );
                }
            ),
            ListTile(
                leading: Icon(
                  Icons.rule,
                  size: 35,

                ),
                title: Text("Terms & Conditions", style: TextStyle(fontSize: 20,),),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>homepage(data: model)),
                  );
                }
            ),
            ListTile(
                leading: Icon(
                  Icons.headphones,
                  size: 35,

                ),
                title: Text("Support", style: TextStyle(fontSize: 20,),),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homepage(data: model)),
                  );
                }
            ),
            ListTile(

                leading: Icon(
                  Icons.question_mark,
                  size: 35,

                ),
                title: Text("Help", style: TextStyle(fontSize: 20,),),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>homepage(data: model)),
                  );
                }
            ),
            ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  size: 35,

                ),
                title: Text("Logout", style: TextStyle(fontSize: 20),),
                onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>signin(data: model)),
                  );
                }

            ),

          ] ),
    ),

  ),
  
);
  }
}
