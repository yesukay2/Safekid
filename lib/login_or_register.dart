import 'package:flutter/material.dart';
import 'package:safekid/login_page.dart';
import 'package:safekid/signup_page.dart';

class Login_or_Register_Page extends StatefulWidget {
  const Login_or_Register_Page({Key? key}) : super(key: key);

  @override
  State<Login_or_Register_Page> createState() => _Login_or_Register_PageState();
}

class _Login_or_Register_PageState extends State<Login_or_Register_Page> {

  //show loginPage initially
  bool showLoginPage = true;

  //toggle LoginPage & registerPage
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        onTap: togglePages,
      );
    }else {
      return SignUp_Page(onTap: togglePages);
    }
  }
}
