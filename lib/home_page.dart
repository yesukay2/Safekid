import 'dart:ui';

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safekid/form_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:safekid/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signOutAction, icon: const Icon(Icons.logout))
        ],
        backgroundColor: Colors.blueGrey,
        leading: Image.asset(
          "lib/images/logo-removebg-preview.jpg",
          fit: BoxFit.contain,
          height: 10,
        ),
        leadingWidth: 100,
        title: const Text(
          "Safekid",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Image.asset(
              "lib/images/childabuse.jpg",
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            child: ElevatedButton.icon(
              autofocus: true,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange.shade500,
                shape: StadiumBorder(),
                fixedSize: Size(200, 60),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Form_Page()));
              },
              icon: Icon(Icons.report_gmailerrorred_outlined,
                size:35,
              ),
              label: Text("Report Case",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedTextKit(
                  isRepeatingAnimation: true,
                  pause: Duration.zero,
                  stopPauseOnTap: true,
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
                            color: Colors.blue.shade900
                        )),
                  ],
                ),
                // const SizedBox(height: 20,),

                // Text("THE GREATEST GIFT TO EVERY CHILD IS A GIFT OF \"MYSELF\"",
                // textAlign: TextAlign.center,
                // style: Theme.of(context).textTheme.labelLarge?.copyWith(
                //   color: Colors.grey.shade800,
                // ),),
                // Text("~ Bright Appiah",
                //   style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey.shade600),
                // )
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
      ),
    );
  }

  void signOutAction() {
    FirebaseAuth.instance.signOut();
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [IconButton(onPressed: signOutAction, icon: Icon(Icons.logout))],
//       ),
//       body: const Center(
//         child: Text("Logged In"),
//       ),
//     );
//   }
//
//   void signOutAction() {
//     FirebaseAuth.instance.signOut();
//   }
// }
