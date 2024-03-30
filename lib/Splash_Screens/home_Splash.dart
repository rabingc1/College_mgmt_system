import 'package:internship/Splash_Screens/splash1.dart';
import 'package:internship/Splash_Screens/splash2.dart';
import 'package:internship/Splash_Screens/splash3.dart';
import 'package:internship/homepage.dart';
import 'package:internship/login_pages/sign_in.dart';
import 'package:internship/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_pages/sign_up.dart';
import '../login_pages/signinandsignupmain.dart';

class first_Splash extends StatefulWidget {
  const first_Splash({super.key});

  @override
  State<first_Splash> createState() => _first_SplashState();
}

class _first_SplashState extends State<first_Splash> {
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(controller: _controller, children: [
          splash1(),
          splash2(),
          splash3(),
        ]),
        Container(
          alignment: Alignment(0, 0.75),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigate to the new page route when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Signinandsignupmain(data: model)),
                  );
                },
                child: Text("Skip"),
              ),
              SmoothPageIndicator(controller: _controller, count: 3),
              GestureDetector(
                onTap: () {
                  final currentPage = _controller.page?.round() ??
                      0; // Default to 0 if _controller.page is null
                  if (currentPage < 2) {
                    // Assuming you have 3 splash screens (indices 0, 1, 2)
                    _controller.nextPage(
                        duration: Duration(milliseconds: 350),
                        curve: Curves.easeIn);
                  } else {
                    // Navigate to the login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Signinandsignupmain(data: model)), // Assuming SignIn widget is correct
                    );
                  }
                },
                child: Text("Next"),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
