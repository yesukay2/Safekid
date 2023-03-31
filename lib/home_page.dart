import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safekid/about_page.dart';
import 'package:safekid/auth_page.dart';
import 'package:safekid/form_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:safekid/library.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDisplayName();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final userId = FirebaseAuth.instance.currentUser?.uid;
  var displayName;


  fetchDisplayName() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    setState(() {
      displayName = userDoc['firstName'];
      return(displayName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
              icon: const Icon(Icons.menu_rounded))
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
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        // shape: ShapeBorder,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("lib/images/profile_icon.png"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${displayName}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.library_books_outlined),
              title: Text('Cases'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRecordsWidget()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_outlined),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>AboutPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Sign Out'),
              onTap: () {
                signOutAction();
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipPath(
            // clipper: BottomWaveClipper(),
            child: Image.asset(
              "lib/images/homePic.jpg",
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
          const SizedBox(
            height: 90,
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
                            color: Colors.blue.shade900)),
                  ],
                ),
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
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthPage()), (route) => route.isFirst);
  }
}

// class BottomWaveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0.0, size.height - 20);
//
//     var firstControlPoint = Offset(size.width / 4, size.height);
//     var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
//     path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
//         firstEndPoint.dx, firstEndPoint.dy);
//
//     var secondControlPoint =
//     Offset(size.width - (size.width / 3.25), size.height - 65);
//     var secondEndPoint = Offset(size.width, size.height - 40);
//     path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
//         secondEndPoint.dx, secondEndPoint.dy);
//
//     path.lineTo(size.width, size.height - 10);
//     path.lineTo(size.width, 0.0);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

