import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:safekid/admin_notification.dart';

enum StatusType { Victim, Witness }

enum CaseCategory {
  Rape,
  Assault_Physical_Abuse,
  Molestation,
  Child_Custody,
  Education,
  Medical,
  Teen_Marriage,
  Child_Support,
  Child__Neglect,
  Online
}

class Form_Page extends StatefulWidget {
  const Form_Page({Key? key}) : super(key: key);

  @override
  State<Form_Page> createState() => _Form_PageState();
}

class _Form_PageState extends State<Form_Page> {
  // final statusController = Co
  final _formKey = GlobalKey<FormState>();
  final locationController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final commentController = TextEditingController();
  final connection = FirebaseFirestore.instance.collection("reports");

  bool victimCheck = false;
  bool witnessCheck = false;
  bool onlineCheck = false;

  final List<String> onlineList = [
    "Child Pornography",
    "Cyberbullying",
    "Sexual Abuse/Harassment",
    "Grooming",
    "Domestic Violence/Abuse",
    "Discriminatory Abuse",
    "Child Labour"
  ];

  String dropdownValue = "choose one";

  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = false;

  StatusType? statusType;
  CaseCategory? caseCategory;

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
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: [
                      const Text(
                        "I am a",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                        height: 25,
                      ),
                      Expanded(
                        child: RadioListTile<StatusType>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: StatusType.Victim,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            groupValue: statusType,
                            tileColor: Colors.deepOrange.shade100,
                            title: Text(StatusType.Victim.name),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                statusType = value;
                                victimCheck = true;
                                witnessCheck = false;
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
                                borderRadius: BorderRadius.circular(7)),
                            tileColor: Colors.blue.shade100,
                            title: Text(StatusType.Witness.name),
                            onChanged: (value) {
                              setState(() {
                                statusType = value;
                                witnessCheck = true;
                                victimCheck = false;
                              });
                            }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  victimCheck
                      ? TextFormField(
                          controller: ageController,
                          decoration: InputDecoration(
                            labelText: "Enter your age",
                            prefixIcon: Icon(Icons.perm_contact_calendar),
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Container(),
                  witnessCheck
                      ? TextFormField(
                          controller: ageController,
                          decoration: InputDecoration(
                            labelText: "Enter Victim's age",
                            prefixIcon: Icon(Icons.perm_contact_calendar),
                            border: OutlineInputBorder(),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Select the category that best describes the incident:",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Rape,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.deepOrange.shade100,
                  title: Text(CaseCategory.Rape.name),
                  onChanged: (value) {
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Assault_Physical_Abuse,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.blue.shade100,
                  title: Text("Assault or Physical Abuse"),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Molestation,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.deepOrange.shade100,
                  title: Text(CaseCategory.Molestation.name),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Child_Custody,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.blue.shade100,
                  title: Text("Child Custody"),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Education,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.deepOrange.shade100,
                  title: Text(CaseCategory.Education.name),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Medical,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.blue.shade100,
                  title: Text(CaseCategory.Medical.name),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Teen_Marriage,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.deepOrange.shade100,
                  title: Text("Teen Marriage"),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Child_Support,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.blue.shade100,
                  title: Text("Child Support"),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Child__Neglect,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.deepOrange.shade100,
                  title: Text("Child Neglect"),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = false;
                    });
                  }),
              const SizedBox(height: 10),
              RadioListTile<CaseCategory>(
                  contentPadding: const EdgeInsets.all(0.0),
                  value: CaseCategory.Online,
                  dense: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  groupValue: caseCategory,
                  tileColor: Colors.blue.shade100,
                  title: Text(CaseCategory.Online.name),
                  onChanged: (value) {
                    // print(value);
                    setState(() {
                      caseCategory = value;
                      onlineCheck = true;
                    });
                  }),
              const SizedBox(
                height: 8,
              ),
              onlineCheck
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(36.0, 0, 0, 0),
                      child: DropdownButtonFormField(
                          hint: Text(
                            "Type of Online Abuse",
                            style: TextStyle(fontSize: 15),
                          ),
                          icon:
                              const Icon(Icons.arrow_drop_down_circle_outlined),
                          elevation: 10,
                          items: onlineList.map<DropdownMenuItem<String>>(
                              (String dropdownValue) {
                            return DropdownMenuItem<String>(
                                value: dropdownValue,
                                child: Text(dropdownValue));
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValue = value!;
                            });
                          }),
                    )
                  : Container(),
              const SizedBox(
                height: 25,
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
                height: 15,
              ),
              TextFormField(
                controller: commentController,
                keyboardType: TextInputType.multiline,
                cursorHeight: 20,
                maxLines: 5,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                style: TextStyle(
                  height: 1.5,
                ),
                decoration: const InputDecoration(
                    labelText: "Optional: Describe the  said incident",
                    prefixIcon: Icon(Icons.insert_comment_outlined),
                    isDense: true,
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 45,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 100),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: Size(100, 40),
                    backgroundColor: Colors.deepOrange,
                    elevation: 15,
                  ),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });

                    //email notification ****not working
                    checkForNewDataAndSendNotification(
                        "records", "yesukay2@gmail.com");

                    if (_formKey.currentState!.validate()) {
                      connection.add({
                        'user_id': userId,
                        'status': statusType?.name,
                        'location': locationController.text,
                        'phone': phoneController.text,
                        'timestamp': Timestamp.now(),
                        'case_category': caseCategory?.name,
                        'age': ageController.text,
                        'online_category': dropdownValue,
                        'comment': commentController.text,
                      });
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                    }
                    Fluttertoast.showToast(
                        msg: "Report Submitted Successfully");
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.library_add_check,
                  ),
                  label: Text("Submit Report"),
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.lightBlue,
                      backgroundColor: Colors.deepOrange,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
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
