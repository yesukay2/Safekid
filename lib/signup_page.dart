import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/login_textfield.dart';
import 'components/button.dart';

class SignUp_Page extends StatefulWidget {
  final Function()? onTap;
  const SignUp_Page({super.key, required this.onTap});



  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {

  //text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();




  //SignUp  Method
  void signUpAction() async{

    //show loading circle
    showDialog(context: context, builder: (context){
      return const Center(child: CircularProgressIndicator(color: Colors.lightBlue, backgroundColor: Colors.deepOrange,),
      );
    });
    try{
      if (passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);
      }else{

      }

      //   pop loading circle
      Navigator.pop(context);

    }on FirebaseAuthException catch (e){
      //   pop loading circle
      Navigator.pop(context);

      if(e.code == 'user-not-found'){
        wrongEmailMessage();
      }else if (e.code == 'wrong-password'){
        wrongPasswordMessage();
      }
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          // reverse: true,
          child: Column(
            //   mainAxisSize: MainAxisSize.min,

            children: [
              const SizedBox(height: 30,),
              const Image(image: AssetImage('lib/images/logo-removebg-preview.png',),
              ),

              const SizedBox(height: 60,),
              Text(
                "Register",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 25,
                  decoration: TextDecoration.underline,
                ),
              ),

              const SizedBox(height: 30,),

              Login_Textfield(
                controller: firstNameController,
                hintText: "Firstname",
                obscureText: false,
              ),

              Login_Textfield(
                controller: lastNameController,
                hintText: "Lastname",
                obscureText: false,
              ),

              Login_Textfield(
                controller: emailController,
                hintText: "E-mail",
                obscureText: false,
              ),

              Login_Textfield(
                controller: phoneController,
                hintText: "Phone Number",
                obscureText: false,
              ),

              Login_Textfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: false,
              ),

              Login_Textfield(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: false,
              ),

              const SizedBox(height: 45),

              Button(
                label: "Register",
                onTap: signUpAction,
              ),

              const SizedBox(height: 45),

              const Text("Already have an account?"),

              const SizedBox(height:5),

              GestureDetector(
                onTap: widget.onTap,
                child: const Text("Login",
                  style: TextStyle(
                      color: Colors.blue),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void wrongEmailMessage() {
    showDialog(context: context, builder: (context){
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });
      return const AlertDialog(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Incorrect E-mail",
          style: TextStyle(color: Colors.lightBlue),),
      );
    });
  }

  void wrongPasswordMessage() {
    showDialog(context: context, builder: (context){
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });
      return const AlertDialog(
        title: Text("Password Mismatch"),
      );
    });
  }




}
