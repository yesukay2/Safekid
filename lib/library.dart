import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safekid/auth_page.dart';
import 'package:safekid/profile_page.dart';
import 'about_page.dart';
import 'home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class UserRecordsWidget extends StatefulWidget {
  @override
  _UserRecordsWidgetState createState() => _UserRecordsWidgetState();
}

class _UserRecordsWidgetState extends State<UserRecordsWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  var displayName;

  bool isCompleted = true;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String?, dynamic>> _userRecords = [];

  void signOutAction() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthPage()),
        (route) => route.isFirst);
  }

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchDisplayName();
    _getUserRecords();

    // Start the timer when the widget is created
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        // Update the UI with the latest data from the database
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Cancel the timer when the widget is disposed
    _timer?.cancel();
  }

  records() async {
    User? user = _auth.currentUser;
    QuerySnapshot snapshot = await _firestore
        .collection('reports')
        .orderBy("timestamp", descending: true)
        .where('user_id', isEqualTo: user!.uid)
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

  Future<void> _getUserRecords() async {
    setState(() {
      isLoading = true;
    });

    User? user = _auth.currentUser;

    if (user != null) {
      records();
    }
  }

  Stream<String> getReportStatusStream() {
    final reportRef = FirebaseFirestore.instance.collection('reports').doc();

    return reportRef.snapshots().map((snapshot) {
      final isCompleted = snapshot.get('isCompleted') as bool;
      return isCompleted.toString();
    });
  }

  Stream<List<Widget>> getPartyHandlerStream() {
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
      key: scaffoldKey,
      body: Column(
        children: [
          isLoading
              ? Container(
                  color: Colors.grey.withOpacity(0.6),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.deepOrange,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return records();
              },
              child: ListView.builder(
                itemCount: _userRecords.length,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Map<String?, dynamic> record = _userRecords[index];
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
                                Text(
                                  "Status: ",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.deepOrange),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(record['status']),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Category: ",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.blue),
                                    ),
                                    const SizedBox(
                                      width: 0,
                                    ),
                                    Text(
                                      record['case_category'] ?? "",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 11,
                                ),
                                if (record['handler'] != '' &&
                                    record['handler'] != null)
                                  Row(
                                    children: [
                                      Text(
                                        "Handler: ",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      ),
                                      StreamBuilder<List<Widget>>(
                                        stream: getPartyHandlerStream(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            if (record['handler'] != null &&
                                                record['handler'] != '') {
                                              var handler = record['handler'];

                                              return Text(
                                                "$handler",
                                                style: TextStyle(
                                                  color: Colors.teal,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              );
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
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                Text('${date.day}/${date.month}/${date.year}'),
                                const SizedBox(
                                  height: 10,
                                ),
                                StreamBuilder<String>(
                                  stream: getReportStatusStream(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      // Display loading spinner or placeholder text\
                                      var statusRef =
                                          record['isCompleted'] ?? false;
                                      var status = statusRef
                                          ? Text(
                                              "Resolved",
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            )
                                          : Text(
                                              "Processing",
                                              style: TextStyle(
                                                color: Colors.yellow.shade800,
                                              ),
                                            );

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
                        Divider(
                          color: Colors.deepOrange,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
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
    );
  }
}
