import 'package:flutter/material.dart';
import 'package:Safekid_Gh/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "Merriweather",
        ),
        home: new AnimatedSplashScreen(
          splash: Image.asset("lib/images/CRI_logo.png"),
          splashIconSize: 300,
          nextScreen: AuthPage(),
          centered: true,
          duration: 5,
          animationDuration: Duration(seconds: 2),
          splashTransition: SplashTransition.fadeTransition,
          curve: Curves.decelerate,
        ),
      );
    });
  }
}
