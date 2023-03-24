import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:safekid/home_page.dart';
import 'package:safekid/model/user_model.dart';
import 'components/login_textfield.dart';

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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          // reverse: true,
          child: Form(
            key: _formKey,
            child: Column(
              //   mainAxisSize: MainAxisSize.min,

              children: [
                const SizedBox(
                  height: 30,
                ),
                const Image(
                  image: AssetImage(
                    'lib/images/logo-removebg-preview.jpg',
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "Safekid",
                  style: TextStyle(
                    color: Colors.purple.shade900,
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
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
                      label: Text("Firstname"),
                    ),
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Firstname Required");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      firstNameController.text = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Lastname"),
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
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Lastname Required");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      lastNameController.text = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("E-mail"),
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
                    obscureText: false,
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
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Phone Number"),
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
                    obscureText: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone Number required";
                      } else if (!RegExp(
                              r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                          .hasMatch(value)) {
                        return "Invalid Phone Number";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phoneController.text = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Password"),
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
                    obscureText: true,
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password Required");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Invalid Password(Min. 6 characters");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      passwordController.text = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Confirm Password"),
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
                    obscureText: true,
                    validator: (value) {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      confirmPasswordController.text = value!;
                    },
                  ),
                ),
                const SizedBox(height: 45),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                  ),
                  onPressed: () {
                    signUpAction(emailController.text, passwordController.text);
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      // fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.lightBlue,
                        backgroundColor: Colors.deepOrange,
                      )
                    : const SizedBox.shrink(),
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
      ),
    );
  }

  void signUpAction(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDetailsToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message, gravity: ToastGravity.CENTER);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.secondName = lastNameController.text;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully", gravity: ToastGravity.CENTER);

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
    return;
  }
}
