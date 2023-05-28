import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Safekid_Gh/auth_page.dart';
import 'package:Safekid_Gh/library.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:Safekid_Gh/profile_page.dart';
import 'package:sizer/sizer.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final userId = FirebaseAuth.instance.currentUser?.uid;
  var displayName;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
        //       icon: const Icon(Icons.menu_rounded))
        // ],
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepOrange,
        animationDuration: Duration(milliseconds: 100),
        items: [
          Icon(Icons.home_outlined, size: 4.w),
          Icon(Icons.library_books_outlined, size: 4.w),
          Icon(Icons.person_outline, size: 4.w)
        ],
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),

      body: IndexedStack(
        index: currentIndex,
        children: [
          Home(),
          UserRecordsWidget(),
          profile()
        ],
      ),
    );
  }

  void signOutAction() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthPage()), (route) => route.isFirst);
  }
}

