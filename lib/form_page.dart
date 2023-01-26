import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum StatusType { Victim, Witness }

class Form_Page extends StatefulWidget {
  const Form_Page({Key? key}) : super(key: key);

  @override
  State<Form_Page> createState() => _Form_PageState();
}

class _Form_PageState extends State<Form_Page> {
  // final statusController = Co
  final locationController = TextEditingController();
  final phoneController = TextEditingController();
  final connection = FirebaseFirestore.instance.collection("reports");
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  // final groupValue = 1;
  StatusType? statusType;

  @override
  void dispose() {
    super.dispose();
    locationController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Child Abuse Case"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: ListView(
          children: [
            ClipPath(
              clipper: BottomWaveClipper(),
              child: Image.asset(
                "lib/images/Defending-the-Innocent.png",
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 35,),
                Row(
                  children: [
                    const Text(
                      "I am a",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(width: 15,height: 25,),
                    Expanded(
                      child: RadioListTile<StatusType>(
                        contentPadding: const EdgeInsets.all(0.0),
                          value: StatusType.Victim,
                          dense: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)
                          ),
                          groupValue: statusType,
                          tileColor: Colors.deepOrange.shade100,
                          title: Text(StatusType.Victim.name),

                          onChanged: (value) {
                          // print(value);
                            setState(() {
                              statusType = value;
                            });
                          }),
                    ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: RadioListTile<StatusType>(
                        contentPadding: const EdgeInsets.all(0.0),
                          value: StatusType.Witness,
                          groupValue: statusType,
                          dense: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)
                          ),
                          tileColor: Colors.blue.shade100,
                          title: Text(StatusType.Witness.name),
                          onChanged: (value) {
                            setState(() {
                              statusType = value;
                            });
                          }),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                  labelText: "Where did the incident happen?",
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: phoneController,
              decoration: const InputDecoration(
                  labelText: "Phone number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 95,
            ),
            ElevatedButton(
              onPressed: () {
                connection.add({
                  'user_id': userId,
                  'status': statusType,
                  'location': locationController.text,
                  'phone': phoneController.text,
                });
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange,
                  ),
              child: const Text("Report"),
            )
          ],
        ),
      ),
    );
  }
}
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 15);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 10.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 3.25), size.height - 1);
    var secondEndPoint = Offset(size.width, size.height - 5);
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