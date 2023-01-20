import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signOutAction, icon: Icon(Icons.logout))],
      ),
      body: const Center(
        child: Text("Logged In"),
      ),
    );
  }

  void signOutAction() {
    FirebaseAuth.instance.signOut();
  }
}
