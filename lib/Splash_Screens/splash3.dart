import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
class splash3 extends StatelessWidget {
  const splash3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(

              child: Lottie.asset('images/Animation - 1708590895235.json')

          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("\n\nLet's dive into our system & Make enrollment. ",
                style: GoogleFonts.libreBaskerville(
                  textStyle: const TextStyle(
                    color: Colors.blue,
                    letterSpacing: .5,
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
