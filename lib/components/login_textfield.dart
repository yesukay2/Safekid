import 'package:flutter/material.dart';

class Login_Textfield extends StatelessWidget {
  final controller;

  final String hintText;

  final bool obscureText;

  const Login_Textfield({super.key,required this.controller, required this.hintText, required this.obscureText});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
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
          hintText: hintText,
        ),

      ),
    );
  }
}

