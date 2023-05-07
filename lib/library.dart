import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safekid/auth_page.dart';
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

  //todo implement responsive status
  bool isCompleted = true;



  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String?, dynamic>> _userRecords = [];

  void signOutAction() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>AuthPage()), (route) => route.isFirst);
  }

  Future<void> _getUserRecords() async {
    setState(() {
      isLoading = true;
    });

    User? user = _auth.currentUser;

    if (user != null) {
      QuerySnapshot snapshot = await _firestore
          .collection('reports').orderBy("timestamp", descending: true)
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


  Stream<String> getReportStatusStream() {
    final reportRef = FirebaseFirestore.instance.collection('reports').doc();

    return reportRef.snapshots().map((snapshot) {
      final isCompleted = snapshot.get('isCompleted') as bool;
      return isCompleted.toString();
    });
  }

  Stream<List<Widget>> getPartyHandlerStream(){
    final reportRef = FirebaseFirestore.instance.collection('reports').doc();

    return reportRef.snapshots().map((snapshot) {
      final social_Welfare = snapshot.get('social_Welfare');
      final DOVVSU = snapshot.get('DOVVSU');
      final CHRAJ = snapshot.get('CHRAJ');
      final family_Court = snapshot.get('family_Court');
      final Ghana_Police = snapshot.get('Ghana_Police');

      return [social_Welfare, DOVVSU, CHRAJ, family_Court, Ghana_Police];

    });
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
            Map<String?,dynamic> record = _userRecords[index];
            Timestamp time = record['timestamp'];
            DateTime date = time.toDate();
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    width: 500,
                    child: ListTile(
                      title: Row(
                        children: [
                          Text("Status: ", style: TextStyle(fontSize: 12,color: Colors.deepOrange),),
                          const SizedBox(width: 12,),
                          Text(record['status']),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const SizedBox(height: 5,),
                          Row(
                            children: [
                              Text("Category: ", style: TextStyle(fontSize: 12, color: Colors.blue),),
                              const SizedBox(width: 0,),
                              Text(record['case_category'] ?? "", style: TextStyle(fontSize: 13),),
                            ],
                          ),
                          const SizedBox(height: 11,),
                          if(record['handler'] != '' && record['handler'] != null)Row(
                            children: [
                              Text("Handler: ", style: TextStyle(fontSize: 12, color: Colors.grey),),
                              const SizedBox(width: 1,),
                              StreamBuilder<List<Widget>>(
                                stream: getPartyHandlerStream(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    if(record['handler'] !=  null && record['handler'] != '')  {
                                      var handler = record['handler'];

                                      return Text("$handler", style: TextStyle(
                                        color: Colors.teal,
                                      ),
                                        overflow: TextOverflow.ellipsis,);
                                    }

                                    return SizedBox.shrink();

                                  }

                                  final reportStatus = snapshot.data!;

                                  if (reportStatus == 'true') {
                                    // Display "completed" message
                                    return Text('Resolved');
                                  } else {
                                    // Display "processing" message
                                    return Text('Processing');
                                  }
                                },
                              ),                            ],
                          ),

                        ],
                      ),
                      trailing: Column(
                        children: [
                          Text('${date.day}/${date.month}/${date.year}'),
                          const  SizedBox(height: 10,),
                      StreamBuilder<String>(
                        stream: getReportStatusStream(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            // Display loading spinner or placeholder text\
                            var statusRef = record['isCompleted'] ?? false;
                            var status = statusRef ? Text("Resolved", style: TextStyle(
                              color: Colors.green,
                            ),) : Text("Processing", style: TextStyle(
                              color: Colors.yellow.shade800,
                            ),);

                          return (status);
                          }

                          final reportStatus = snapshot.data!;

                          if (reportStatus == 'true') {
                            // Display "completed" message
                            return Text('Resolved');
                          } else {
                            // Display "processing" message
                            return Text('Processing');
                          }
                        },
                      ),
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.deepOrange,),
                ],
              ),

            );
          },
        ),
      ],
      ),
    );
  }
}
