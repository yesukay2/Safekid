import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safekid/home_page.dart';
import 'about_page.dart';
import 'auth_page.dart';
import 'library.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

final userId = FirebaseAuth.instance.currentUser?.uid;
var displayName;

class _profileState extends State<profile> {
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDisplayName();
  }

  fetchDisplayName() async {
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      displayName = userDoc['firstName'];
      return (displayName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              title: Text('Home'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_outlined),
              title: Text('About Us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Sign Out'),
              onTap: () {
                signOutAction();
              },
            ),
            const SizedBox(height: 335,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextLiquidFill(
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  void signOutAction() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthPage()),
        (route) => route.isFirst);
  }
}
