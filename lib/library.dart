import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'about_page.dart';
import 'home_page.dart';

class UserRecordsWidget extends StatefulWidget {
  @override
  _UserRecordsWidgetState createState() => _UserRecordsWidgetState();
}

class _UserRecordsWidgetState extends State<UserRecordsWidget> {
  @override
  void initState() {
    super.initState();
    _getUserRecords();
    fetchDisplayName();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  var displayName;



  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String?, dynamic>> _userRecords = [];

  void signOutAction() {
    FirebaseAuth.instance.signOut();
  }

  // Future<String?> _getUserData() async {
  //   final String uid = FirebaseAuth.instance.currentUser!.uid;
  //   final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //   setState(() {
  //     _userName = (userDoc.data() as Map )['name'];
  //   });
  //   return(_userName);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getUserRecords();
  // }

  Future<void> _getUserRecords() async {
    setState(() {
      isLoading = true;
      print("set to true");
    });

    User? user = _auth.currentUser;

    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('reports')
          .where('user_id', isEqualTo: user.uid)
          .get();
      List<Map<String?, dynamic>> cases = [];
      snapshot.docs.forEach((doc) {
        cases.add(doc.data() as Map<String?, dynamic>);
      });
      setState(() {
        _userRecords = cases;
        isLoading = false;
      });
    }
  }


  fetchDisplayName() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    setState(() {
      displayName = userDoc['firstName'];
      return(displayName);
    });
      print(displayName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
          "My Cases",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
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
                    "${displayName}",
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
          ],
        ),
      ),

      body: Stack(
        children: [isLoading
      ? Container(
      color: Colors.grey.withOpacity(0.6),
      child: Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrange,
              color: Colors.blueAccent,
            ),
          )),
    )
        : SizedBox.shrink(),
          ListView.builder(
          itemCount: _userRecords.length,
          itemBuilder: (context, index) {
            Map<String?, dynamic> record = _userRecords[index];
            var time = record['timestamp'] as Timestamp;
            DateTime date = time.toDate();
            return SizedBox(
              width: 500,
              child: ListTile(
                title: Text(record['status']),
                subtitle: Text(record['case_category']),
                trailing: Text('(${date.day}/${date.month}/${date.year}'),
              ),
            );
          },
        ),
      ],
      ),
    );
  }
}
