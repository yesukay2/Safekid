import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Safekid_Gh/home_page.dart';
import 'package:sizer/sizer.dart';
import 'about_page.dart';
import 'auth_page.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

final user = FirebaseAuth.instance.currentUser;
final userId = user?.uid;
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
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

          Expanded(
            child: Column(
              children: [
                ListTile(
                  horizontalTitleGap: 2,
                  dense: true,
                  leading: Icon(Icons.library_books_outlined, size: 4.5.w),
                  title: Text('Home', style: TextStyle(fontSize: 3.w)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                ListTile(
                  horizontalTitleGap: 2,
                  dense: true,
                  leading: Icon(Icons.account_balance_outlined, size: 4.5.w),
                  title: Text('About Us', style: TextStyle(fontSize: 3.w)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AboutPage()));
                  },
                ),
                ListTile(
                  horizontalTitleGap: 2,
                  dense: true,
                  leading: Icon(Icons.lock_outline, size: 4.5.w),
                  title: Text('Sign Out', style: TextStyle(fontSize: 3.w)),
                  onTap: () {
                    signOutAction();
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: ListTile(
                    horizontalTitleGap: 2,
                    dense: true,
                    leading: Icon(Icons.delete_forever_outlined, size: 4.5.w, color: Colors.red),
                    title:
                        Text('Delete Account', style: TextStyle(fontSize: 3.w)),
                    onTap: () {
                      deleteAccountAction();
                    },
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 259,
          // ),
          Align(
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
        ],
      ),
    );
  }

  void signOutAction() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthPage()),
        (route) => route.isFirst);
  }

  void deleteAccountAction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                user!.delete();
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AuthPage()),
                    (route) => route.isFirst);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
