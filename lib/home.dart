import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Safekid_Gh/auth_page.dart';
import 'package:Safekid_Gh/form_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        // Expanded(
        //   child: const SizedBox(
        //     height: 40,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0,50,0,20),
          child: Container(
            child: ElevatedButton.icon(
              autofocus: true,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange.shade500,
                shape: StadiumBorder(),
                side: BorderSide(
                  style: BorderStyle.solid,
                  width: 1.h,
                  color: Colors.white60,
                ),
                fixedSize: Size(50.w, 8.h),
                elevation: 20,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Form_Page()));
              },
              icon: Icon(
                Icons.report_gmailerrorred_outlined,
                size: 4.h,
              ),
              label: Text(
                "Report Case",
                style: TextStyle(fontSize: 2.5.h),
              ),
            ),
          ),
        ),
        // const SizedBox(
        //   height: 30,
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: AnimatedTextKit(
            isRepeatingAnimation: true,
            pause: Duration(seconds:0),
            stopPauseOnTap: false,
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText(
                "The Greatest Gift To Every Child Is A Gift Of \"Myself\"\n ~Bright Appiah",
                duration: Duration(milliseconds: 8000),
                // textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                // colors: [
                //   Colors.blue.shade900,
                //   Colors.deepOrange,
                //   Colors.brown,
                //   Colors.brown.shade300,
                //   Colors.black45
                // ],
                textStyle: TextStyle(
                  fontSize: 3.h,
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
                      fontSize: 3.h,
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
              boxHeight: 10.h,
              boxWidth: 100.w,
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

