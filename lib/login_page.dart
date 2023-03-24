import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safekid/passwordReset_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _loginKey = GlobalKey<FormState>();

  //text editting controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Signin  Method
  void signInAction() async {
    //show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.lightBlue,
              backgroundColor: Colors.deepOrange,
            ),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      //   pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //   pop loading circle
      Navigator.pop(context);

      if (e.code == 'user-not-found') {
        // wrongEmailMessage();
        Fluttertoast.showToast(
            msg: "User not found",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red.shade500,
            toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'wrong-password') {
        // wrongPasswordMessage();
        Fluttertoast.showToast(
            msg: "Incorrect Password",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red.shade500,
            toastLength: Toast.LENGTH_LONG);
      }
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please enter required details!",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red.shade500,
            toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg: "Invalid Credentials!",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red.shade500,
            toastLength: Toast.LENGTH_LONG);
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
              Form(
                key: _loginKey,
                child: Container(
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage(
                          'lib/images/logo-removebg-preview.jpg',
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 25,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: emailController,
                          obscureText: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "E-mail",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepOrange),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("E-mail required!");
                            }
                            if (!RegExp(
                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Invalid E-mail");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepOrange),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Enter Password");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return passwordReset_page();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 45),
                      ElevatedButton(
                        child: Text("Sign In"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(95, 40),
                          backgroundColor: Colors.deepOrange,
                          elevation: 15,
                        ),
                        onPressed: signInAction,
                      ),
                      const SizedBox(height: 45),
                      const Text("Don't have an account?"),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.blue),
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
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return const AlertDialog(
            title: Text(
              "Incorrect Password",
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }
}