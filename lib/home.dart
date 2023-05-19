import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safekid/about_page.dart';
import 'package:safekid/auth_page.dart';
import 'package:safekid/form_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:safekid/library.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:safekid/profile_page.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final userId = FirebaseAuth.instance.currentUser?.uid;
  var displayName;

  int currentIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ClipPath(
          child: Image.asset(
            "lib/images/homePic.jpg",
            fit: BoxFit.cover,
            // height: 300,
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Container(
          child: ElevatedButton.icon(
            autofocus: true,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange.shade500,
              shape: StadiumBorder(),
              side: BorderSide(
                style: BorderStyle.solid,
                width: 3,
                color: Colors.white60,
              ),
              fixedSize: Size(180, 50),
              elevation: 20,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Form_Page()));
            },
            icon: Icon(
              Icons.report_gmailerrorred_outlined,
              size: 30,
            ),
            label: Text(
              "Report Case",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            pause: Duration.zero,
            stopPauseOnTap: false,
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                "THE GREATEST GIFT TO EVERY CHILD IS A GIFT OF \"MYSELF\"\n\n ~Bright Appiah",
                speed: Duration(milliseconds: 110),
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                colors: [
                  Colors.blue.shade900,
                  Colors.deepOrange,
                  Colors.brown,
                  Colors.brown.shade300,
                  Colors.black45
                ],
                textStyle: TextStyle(
                  fontSize: 19,
                  fontFamily: "Arima",
                ),
              ),
              TypewriterAnimatedText(
                  "An Adult is a Child who has Survived",
                  curve: Curves.easeInOutSine,
                  textAlign: TextAlign.center,
                  speed: Duration(milliseconds: 160),
                  textStyle: TextStyle(
                      fontFamily: "Arima",
                      fontSize: 20,
                      color: Colors.blue.shade900)),
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextLiquidFill(
              text: "",
              textAlign: TextAlign.center,
              loadUntil: 0.8,
              waveDuration: Duration(milliseconds: 1100),
              boxBackgroundColor: Colors.transparent,
              waveColor: Colors.deepOrange.shade500,
              textStyle: TextStyle(fontSize: 15, color: Colors.blue),
              loadDuration: Duration(milliseconds: 1100),
              boxHeight: 70,
            ),
          ),
        ),
      ],
    );
  }

  void signOutAction() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthPage()), (route) => route.isFirst);
  }
}

