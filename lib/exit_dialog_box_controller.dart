import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship/login_pages/sign_in.dart';

import 'model.dart';

class ExitConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: const Center(child: Text('CMS')),
      content: Text('Are you sure you want to exit?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            exit(0); // it will  Exit the app you recom.. xaina haii iphone ma tw 0 used garyeo vane account naii block gardenxa re
          },
          child: Text('Yes'),
        ),
      ],
    );
  }



}
class ExitConfirmationDialoghomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: const Center(child: Text('CMS ID WILL BE LOGOUT',style: TextStyle(fontSize: 15),)),

      content: Text('Are you sure you want to exit?',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('No',style: TextStyle(color: Colors.green)),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      signin(data: model)),
            );
           // exit(0); // it will  Exit the app you recom.. xaina haii iphone ma tw 0 used garyeo vane account naii block gardenxa re
          },
          child: Text('Yes',style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }



}