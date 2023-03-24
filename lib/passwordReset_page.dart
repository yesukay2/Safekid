import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class passwordReset_page extends StatefulWidget {
  const passwordReset_page({Key? key}) : super(key: key);

  @override
  State<passwordReset_page> createState() => _passwordReset_pageState();
}

class _passwordReset_pageState extends State<passwordReset_page> {
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Enter your E-mail to recieve a password reset link...",
                    textAlign: TextAlign.center,
                  ),
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
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                ElevatedButton(
                  onPressed: resetPassword,
                  child: Text("Send Link"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    elevation: 15,
                  ),
                ),
              ],
            ),
          ),
          isLoading
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
              : SizedBox.shrink()
        ],
      ),
    );
  }

  Future resetPassword() async {

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

        isLoading = false;
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg:
            "Link sent seccessfully..Check your inbox and click link to reset password!",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red.shade500,
      );
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red.shade500,
          toastLength: Toast.LENGTH_LONG);
    }setState(() {
      isLoading=false;
    });
  }
}
