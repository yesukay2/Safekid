import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safekid/form_page.dart';
import 'package:safekid/login_page.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signOutAction, icon: const Icon(Icons.logout))],
        backgroundColor: Colors.blueGrey,
        leading: Image.asset("lib/images/logo-removebg-preview.png",
        fit: BoxFit.contain,
        height: 10,),
        leadingWidth: 100,
        title: const Text("Safekid",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600
        ),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Image.asset(
              "lib/images/childabuse.jpg",
              fit: BoxFit.cover,
              height: 300,
            ),
          ),

          const SizedBox(height: 120,),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent
    ),
              child: const Text('Report Abuse Case',
              style: TextStyle(
                color: Colors.white,
              ),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Form_Page()));
              },
            ),
          ),

          const SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,5,10,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("THE GREATEST GIFT TO EVERY CHILD IS A GIFT OF \"MYSELF\"",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.grey.shade800,
                ),),
                Text("~ Bright Appiah",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey.shade600),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
   void signOutAction() {
    FirebaseAuth.instance.signOut();
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;


}






// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [IconButton(onPressed: signOutAction, icon: Icon(Icons.logout))],
//       ),
//       body: const Center(
//         child: Text("Logged In"),
//       ),
//     );
//   }
//
//   void signOutAction() {
//     FirebaseAuth.instance.signOut();
//   }
// }
