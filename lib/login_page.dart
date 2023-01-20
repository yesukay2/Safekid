import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safekid/signup_page.dart';
import 'components/login_textfield.dart';
import 'components/button.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});



  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editting controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  

  //Signin  Method
   void signInAction() async{
     
      //show loading circle
     showDialog(context: context, builder: (context){
       return const Center(child: CircularProgressIndicator(color: Colors.lightBlue, backgroundColor: Colors.deepOrange,),
       );
     });
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);

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
          reverse: true,
          child: Column(
          //   mainAxisSize: MainAxisSize.min,

            children: [
              const SizedBox(height: 30,),
              const Image(image: AssetImage('lib/images/logo-removebg-preview.png',),
              ),

              const SizedBox(height: 60,),
              Text(
                "Login",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 25,
                  decoration: TextDecoration.underline,
                ),
              ),

              const SizedBox(height: 30,),

              Login_Textfield(
                controller: emailController,
                hintText: "E-mail",
                obscureText: false,
              ),

              Login_Textfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("Forgot Password?",
                      style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),),
                  ],
                ),
              ),

              const SizedBox(height: 45),

              Button(
                label: "Sign In",
                onTap: signInAction,
              ),

              const SizedBox(height: 45),

              const Text("Don't have an account?"),

              const SizedBox(height:5),

              GestureDetector(
                onTap: widget.onTap,
                child: const Text("Register",
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
         style: TextStyle(color: Colors.white),),
       );
     });
  }

  void wrongPasswordMessage() {
    showDialog(context: context, builder: (context){
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop(true);
      });
      return const AlertDialog(
        title: Text("Incorrect Password",
          style: TextStyle(color: Colors.white),
        ),

      );
    });
  }
}
