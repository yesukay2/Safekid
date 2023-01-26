import 'package:flutter/material.dart';

class Login_Textfield extends StatelessWidget {
  final controller;

  final String hintText;

  final bool obscureText;

  final validate;

  final onSaved;

  const Login_Textfield({super.key,required this.controller, required this.hintText, required this.obscureText, required this.validate, required this.onSaved});


  // validate(value){
  //   if(value == null || value == ""){
  //     return("Please enter your Email");
  //   }
  //   else if(RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[A-Z]")){
  //
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextFormField(
        controller: controller,
        validator: validate,
        onSaved: onSaved,
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

