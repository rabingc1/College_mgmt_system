



import 'package:flutter/material.dart';

List<imageModel> model = [
  imageModel(image: "images/academicinfo.png", Name: "AcademicInfo"),     //0
  imageModel(image: "images/assignment.png", Name: "Assignment"),       //1
  imageModel(image: "images/event.png", Name: "Upcoming Event"),        //2
  imageModel(image: "images/login.png", Name: "Homepage"),          //3
  imageModel(image: "images/result.png", Name: "View Result"),      //4
  imageModel(image: "images/timetable.png", Name: "Time Table"),    //5
  imageModel(image: "images/faculty.png", Name: "faculty"),       //6
  imageModel(image: "images/signin.png", Name: "signin"),         //7
  imageModel(image: "images/login.png", Name: "Homepage"),      //8
  imageModel(image: "images/app.png", Name: "app"),         //9

  imageModel(image: "images/attendance.png", Name: "attendance"),//10
  imageModel(image: "images/settings.png", Name: "setting"),    //11
  imageModel(image: "images/backpic.jpg", Name: "backpic")//12





];



class imageModel {
  String image;
  String Name;
  imageModel ({
    required this.image,
    required this.Name,
  });


  // Getter for the length of the model list
  static int get modelLength => model.length;
}


