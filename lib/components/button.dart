import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final label;
  var buttonAction = (){};
  final Function()? onTap;

   Button({super.key, required this.label, required this.onTap});



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width,
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20,20,20,20),
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(label,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),),
            ),
          ),
        ],
      ),
    );
  }
}
