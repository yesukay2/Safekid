import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Safekid_Gh/home_page.dart';
import 'package:Safekid_Gh/login_or_register.dart';




class AuthPage extends StatefulWidget {

  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   Future.delayed(Duration(seconds: 3)).then((value) {
  //   FlutterNativeSplash.remove();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return HomePage();
          }else {
            return const Login_or_Register_Page();
          }
        },
      ),
    );
  }
}
