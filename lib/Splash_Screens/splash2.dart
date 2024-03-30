import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
class splash2 extends StatelessWidget {
  const splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(



            child: Lottie.asset(

                height: 450,
                width: 2000,'images/Animation - 1708590530189.json')

          ),
          Text("> Excellecnce, \n> Innovation, \n> Community, \n> Integrity.",
              style: GoogleFonts.libreBaskerville(
                textStyle: const TextStyle(
                  color: Colors.blue,
                  letterSpacing: .5,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),

    );
  }
}
