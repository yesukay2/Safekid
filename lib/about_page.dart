
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:safekid/auth_page.dart';
import 'package:safekid/home_page.dart';
import 'library.dart';

class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    fetchDisplayName();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final connection = FirebaseFirestore.instance.collection("users");
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseAuth auth = FirebaseAuth.instance;
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

  // QuerySnapshot snapshot = await connection
  @override
  Widget build(BuildContext context) {
  void signOutAction() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthPage()), (route) => route.isFirst);
  }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=>scaffoldKey.currentState!.openEndDrawer(), icon: const Icon(Icons.menu))
        ],
        backgroundColor: Colors.blueGrey,
        leading: Image.asset(
          "lib/images/logo-removebg-preview.jpg",
          fit: BoxFit.contain,
          height: 10,
        ),
        leadingWidth: 100,
        title: const Text(
          "Child Rights Int.",
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
              leading: Icon(Icons.home_outlined),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.library_books_outlined),
              title: Text('Cases'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRecordsWidget()));

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mission',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.underline
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                'Our mission is to promote and protect the inherent dignity of every child, and address the fundamental needs of children',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 16,
              ),

              Text(
                'Steps to take when you notice any instance of Child Abuse',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.red,
                decoration: TextDecoration.underline,

                ),
                textAlign: TextAlign.center,
              ),
              BulletedList(
                listItems: [
                  "step 1",
                  "step 2",
                  "step 3",
                  "step 4",
                  "step 5",
                ],
                bullet: Icon(Icons.play_arrow_rounded, color: Colors.deepOrange,size: 18,),
                style: TextStyle(),
              ),
              SizedBox(
                height: 50,
              ),

                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Contact Us:',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.underline
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,size: 20,),
                    SizedBox(width: 4.0),
                    Text(
                      'Address ',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Text(
                      ": Adumua St",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blueAccent
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.location_city_rounded, size: 20,),
                    SizedBox(width: 4.0),
                    Text(
                      "City ",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Text(
                      ": Dzorwulu, Accra ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blueAccent
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.map_outlined,size: 20,),
                    SizedBox(width: 4.0),
                    Text(
                      "Region ",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Text(
                      ": Greater Accra ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blueAccent
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.phone_iphone, size: 20,),
                    SizedBox(width: 4.0),
                    Text(
                      "Phone ",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Text(
                      ": 0302503744",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blueAccent
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.email_outlined, size: 20,),
                    SizedBox(width: 4.0),
                    Text(
                      "E-mail ",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    Text(
                      ": info@crighana.org ",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blueAccent
                      ),
                    ),
                  ],
                ),


              const SizedBox(height: 50,),
              Container(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Text('App developed by Yesu K. Apraku'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
