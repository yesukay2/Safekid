import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:safekid/home_page.dart';
import 'package:safekid/model/user_model.dart';
import 'components/login_textfield.dart';
import 'components/button.dart';

class SignUp_Page extends StatefulWidget {
  final Function()? onTap;

  const SignUp_Page({super.key, required this.onTap});

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {

  //form key
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  //text editing controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //SignUp  Method
  // void signUpAction() async {
  //   //show loading circle
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Center(
  //           child: CircularProgressIndicator(
  //             color: Colors.lightBlue,
  //             backgroundColor: Colors.deepOrange,
  //           ),
  //         );
  //       });
  //   try {
  //     if (passwordController.text == confirmPasswordController.text) {
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //           email: emailController.text, password: passwordController.text);
  //     } else {
  //       PasswordMismatchMessage();
  //     }
  //
  //     //   pop loading circle
  //     Navigator.pop(context);
  //   } on FirebaseAuthException catch (e) {
  //     //   pop loading circle
  //     Navigator.pop(context);
  //
  //     // if(e.code == 'user-not-found'){
  //     //   wrongEmailMessage();
  //     // }else if (e.code == 'wrong-password'){
  //     //   wrongPasswordMessage();
  //     // }
  //   }
  // }

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
              const SizedBox(
                height: 30,
              ),
              const Image(
                image: AssetImage(
                  'lib/images/logo-removebg-preview.png',
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "Register",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 25,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Login_Textfield(
                controller: firstNameController,
                hintText: "Firstname",
                obscureText: false,
                validate: (value){
                  if(value!.isEmpty){
                    return("Lastname Required");
                  }
                  return null;
                },
              ),
              Login_Textfield(
                controller: lastNameController,
                hintText: "Lastname",
                obscureText: false,
                validate: (value){
                  if(value!.isEmpty){
                    return("Lastname Required");
                  }
                  return null;
                },
              ),
              Login_Textfield(
                controller: emailController,
                hintText: "E-mail",
                obscureText: false,
                validate: (value){
                  if(value!.isEmpty){
                    return("E-mail required!");
                  }if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)){
                    return("Invalid E-mail");
                  }
                },
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
                validate: (value){
                  RegExp regex = RegExp(r'^.{6,}$');
                  if(value!.isEmpty){
                    return("Password Required");
                  }
                  if(!regex.hasMatch(value)){
                    return("Enter Valid Password(Min. 6 characters");
                  }
                },
              ),
              Login_Textfield(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: false,
                validate: (value) {
                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    return "Password don't match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 45),

              ElevatedButton(
                onPressed: () {
                  signUpAction(emailController.text, passwordController.text);
                },
                child:
                const Text("Register",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),

              ),),


              const SizedBox(height: 45),
              const Text("Already have an account?"),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: widget.onTap,
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return const AlertDialog(
            backgroundColor: Colors.deepOrangeAccent,
            title: Text(
              "Incorrect E-mail",
              style: TextStyle(color: Colors.lightBlue),
            ),
          );
        });
  }

  void PasswordMismatchMessage() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return const AlertDialog(
            title: Text("Password Mismatch"),
          );
        });
  }


  void signUpAction(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password)
          .then((value) => {
      postDetailsToFirestore(),
      }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async
  {
    //  calling firestore
    //  calling user model
    //  send values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user!.uid;
    userModel.firstName = firstNameController.text;
    userModel.secondName = lastNameController.text;

    await firebaseFirestore
        .collection('user')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => HomePage()), (
        route) => false);
    return;
  }

}
