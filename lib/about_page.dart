import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:sizer/sizer.dart';

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
    final DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
    setState(() {
      displayName = userDoc['firstName'];
      return (displayName);
    });
  }

  // QuerySnapshot snapshot = await connection
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: Image.asset(
              "lib/images/logo-removebg-preview.jpg",
              fit: BoxFit.contain,
              height: 10,
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey,
        // leading: Image.asset(
        //   "lib/images/logo-removebg-preview.jpg",
        //   fit: BoxFit.contain,
        //   height: 10,
        // ),
        // leadingWidth: 100,
        title: const Text(
          "Child Rights Int.",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      // endDrawer: Drawer(
      //   // shape: ShapeBorder,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             CircleAvatar(
      //               radius: 50,
      //               backgroundImage: AssetImage("lib/images/profile_icon.png"),
      //             ),
      //             SizedBox(height: 10),
      //             Text(
      //               '${displayName}',
      //               style: TextStyle(
      //                 color: Colors.black,
      //                 fontSize: 18,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.home_outlined),
      //         title: Text('Home'),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => HomePage()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.library_books_outlined),
      //         title: Text('Cases'),
      //         onTap: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => UserRecordsWidget()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.lock_outline),
      //         title: Text('Sign Out'),
      //         onTap: () {
      //           signOutAction();
      //         },
      //       ),
      //     ],
      //   ),
      // ),
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
                        fontSize: 4.5.w,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.underline,
                    color: Colors.deepOrange),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Text(
                'Our mission is to promote and protect the inherent dignity of every child, and address the fundamental needs of children',
                style: TextStyle(
                  fontSize: 3.w,
                  height: 1.5,
                  color:Colors.blueGrey.shade900,
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 1,
              ),
              Text(
                'Steps to take when you notice any instance of Child Abuse',
                style: TextStyle(
                  fontSize: 4.5.w,
                  fontWeight: FontWeight.w100,
                  color: Colors.deepOrange,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),
              BulletedList(
                crossAxisAlignment: CrossAxisAlignment.center,
                listItems: [
                  Text("Identify instance of abuse", style: TextStyle(fontSize: 3.w),),
                  Text("Report case to Child Rights Int. using Safekid App", style: TextStyle(fontSize: 3.w),),
                  Text("Await referral", style: TextStyle(fontSize: 3.w),),
                  Text("Follow up on case", style: TextStyle(fontSize: 3.w),),
                ],
                bullet: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.deepOrange,
                  size: 3.w,
                ),
                style: TextStyle(
                  fontFamily: "Merriweather",
                  color: Colors.blueGrey.shade900,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                alignment: FractionalOffset.bottomCenter,
                decoration: BoxDecoration(color: Colors.deepOrange.shade500),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                  child: Column(
                    children: [
                      Text(
                        'Contact Us:',
                        style: TextStyle(
                            fontSize: 4.w,
                            fontWeight: FontWeight.w200,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 4.w,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            'Address ',
                            style: TextStyle(
                              fontSize: 2.5.w,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            ": Adumua St",
                            style:
                            TextStyle(fontSize: 2.1.w, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_city_rounded,
                            size: 4.w,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            "City ",
                            style: TextStyle(
                              fontSize: 2.5.w,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            ": Dzorwulu, Accra ",
                            style:
                            TextStyle(fontSize: 2.1.w, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.map_outlined,
                            size: 4.w,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            "Region ",
                            style: TextStyle(
                              fontSize: 2.5.w,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            ": Greater Accra ",
                            style:
                            TextStyle(fontSize: 2.1.w, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.phone_iphone,
                            size: 4.w,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            "Phone ",
                            style: TextStyle(
                              fontSize: 2.5.w,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            ": 0302503744",
                            style:
                            TextStyle(fontSize: 2.1.w, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 4.w,
                          ),
                          SizedBox(width: 4.0),
                          Text(
                            "E-mail ",
                            style: TextStyle(
                              fontSize: 2.5.w,
                              color: Colors.white54,
                            ),
                          ),
                          Text(
                            ": info@crighana.org ",
                            style:
                            TextStyle(fontSize: 2.1.w, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.copyright_outlined, color: Colors.white70,),
                                  Text(
                                    'Child Rights International',
                                    style: TextStyle(
                                        color: Colors.white54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.white54,
                            ),
                            Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Text(
                                'App developed by Yesu K. Apraku',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontStyle: FontStyle.italic
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
