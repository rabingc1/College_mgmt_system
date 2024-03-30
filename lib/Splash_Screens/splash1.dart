import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class splash1 extends StatelessWidget {
  const splash1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          children: [
            Lottie.asset(height: 500, 'images/Animation - 1708536542743.json'),
            /*Text(" WELCOME TO COLLEGE MANAGMENT SYSTEM. ",
                style: GoogleFonts.libreBaskerville(
                  textStyle: TextStyle(color: Colors.blue, letterSpacing: .5,fontSize: 15,fontWeight: FontWeight.bold),
                ),
              ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("WELCOME TO COLLEGE MANAGMENT SYSTEM.",
                  style: GoogleFonts.libreBaskerville(
                    textStyle: const TextStyle(
                      color: Colors.blue,
                      letterSpacing: .5,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
            Text(""),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Our system provides a user-friendly experience & ensuring enrollment is effortless and efficient. ",
                  style: GoogleFonts.voces(
                    textStyle: const TextStyle(
                      color: Colors.blue,
                      letterSpacing: .5,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
