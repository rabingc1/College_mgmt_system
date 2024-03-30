import 'package:firebase_core/firebase_core.dart';
import 'package:internship/login_pages/signinandsignupmain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Splash_Screens/home_Splash.dart';

import 'firebase_options.dart';
import 'homepage.dart';
import 'model.dart';

Future<void> main()   async {
  WidgetsFlutterBinding.ensureInitialized();

await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: first_Splash(),
       // Signinandsignupmain( data: model),
        //homepage(data: model)
    );
  }

}