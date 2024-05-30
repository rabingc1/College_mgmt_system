import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internship/login_pages/signinandsignupmain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internship/pages/academicInfo.dart';
import 'package:internship/pages/assignment.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'Splash_Screens/home_Splash.dart';

import 'firebase_options.dart';
import 'homepage.dart';
import 'model.dart';

Future<void> main()   async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,);

  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',

        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/', // Define initial route
        routes: {
          '/': (context) => first_Splash(), // Define home screen route
          '/academicinfo': (context) => AcademicInfoPage(),
          '/Assignment': (context)  => LoadFirebaseStoragePdf(),


          // Define second screen route
        },


       // Signinandsignupmain( data: model),
        //homepage(data: model)
    );
  }

}

