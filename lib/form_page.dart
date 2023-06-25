import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

enum StatusType { Victim, Witness_Informant }

enum CaseCategory {
  Rape,
  Assault_Physical_Abuse,
  Molestation,
  Child_Custody,
  Education,
  Medical,
  Teen_Marriage,
  Child_Support,
  Child_Neglect,
  Suicidal,
  Online
}

class Form_Page extends StatefulWidget {
  const Form_Page({Key? key}) : super(key: key);

  @override
  State<Form_Page> createState() => _Form_PageState();
}

final _formKey = GlobalKey<FormState>();

bool _validate() {
  return _formKey.currentState!.validate();
}

class _Form_PageState extends State<Form_Page> {
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

  String? dropdownValue;

  String? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool isLoading = false;

  StatusType? statusType;
  CaseCategory? caseCategory;

  bool hasErrorMessage = false;

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
        title: const Text("Report Abuse Case"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: FormField(
                builder: (FormFieldState<dynamic> state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ClipRect(
                          // clipper: BottomWaveClipper(),
                          child: Image.asset(
                            "lib/images/formPic.jpg",
                            fit: BoxFit.cover,
                            // height: 300,
                            // width: 100,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
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
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                    height: 25,
                                  ),
                                  Expanded(
                                    child: RadioListTile<StatusType>(
                                        contentPadding:
                                            const EdgeInsets.all(0.0),
                                        toggleable: true,
                                        value: StatusType.Victim,
                                        dense: true,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(17),
                                          side: BorderSide(
                                            style: BorderStyle.solid,
                                            color: Colors.deepOrange.shade500,
                                          ),
                                        ),
                                        groupValue: statusType,
                                        // tileColor: Colors.deepOrange.shade100,
                                        title: Text(StatusType.Victim.name),
                                        onChanged: (value) {
                                          // print(value);
                                          setState(() {
                                            statusType = value!;
                                            victimCheck = true;
                                            witnessCheck = false;
                                          });
                                        }),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: RadioListTile<StatusType>(
                                        activeColor: Colors.deepOrange,
                                        contentPadding:
                                            const EdgeInsets.all(0.0),
                                        toggleable: true,
                                        value: StatusType.Witness_Informant,
                                        groupValue: statusType,
                                        dense: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(17),
                                            side: BorderSide(
                                              color: Colors.blue.shade900,
                                            )),
                                        // tileColor: Colors.blue.shade100,
                                        title: Text("Witness/Informant"),
                                        onChanged: (value) {
                                          setState(() {
                                            statusType = value!;
                                            witnessCheck = true;
                                            victimCheck = false;
                                          });
                                        }),
                                  ),
                                  Text(
                                    state.errorText ?? "",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Age :",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: SizedBox(
                                      width: 300,
                                      child: TextFormField(
                                        style: TextStyle(height: 0.5),
                                        controller: ageController,
                                        validator: (value) {
                                          // print(caseCategory);
                                          //validate category check
                                          if (caseCategory == null) {
                                            setState(() {
                                              hasErrorMessage = true;
                                            });
                                          }
                                          if (value == null || value == "") {
                                            return ("Age required!");
                                          }

                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          labelText: victimCheck
                                              ? "Enter your age"
                                              : "Enter Victim's age",
                                          prefixIcon:
                                              Icon(Icons.perm_contact_calendar),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Select the category that best describes the incident:",
                                softWrap: true,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.8,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Rape,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.deepOrange.shade500,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.deepOrange.shade100,
                            title: Text(CaseCategory.Rape.name),
                            onChanged: (value) {
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Assault_Physical_Abuse,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.blue.shade900,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.blue.shade100,
                            title: Text("Assault or Physical Abuse"),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Molestation,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.deepOrange.shade500,
                                )),
                            groupValue: caseCategory,
                            title: Text(CaseCategory.Molestation.name),
                            onChanged: (value) {
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Child_Custody,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.blue.shade900,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.blue.shade100,
                            title: Text("Child Custody"),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Education,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.deepOrange.shade500,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.deepOrange.shade100,
                            title: Text(CaseCategory.Education.name),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Medical,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.blue.shade900,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.blue.shade100,
                            title: Text(CaseCategory.Medical.name),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Teen_Marriage,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.deepOrange.shade500,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.deepOrange.shade100,
                            title: Text("Teen Marriage"),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Child_Support,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.blue.shade900,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.blue.shade100,
                            title: Text("Child Support"),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Child_Neglect,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.deepOrange.shade500,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.deepOrange.shade100,
                            title: Text("Child Neglect"),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = false;
                              });
                            }),
                        const SizedBox(height: 10),
                              RadioListTile<CaseCategory>(
                                  contentPadding: const EdgeInsets.all(0.0),
                                  value: CaseCategory.Suicidal,
                                  dense: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                      side: BorderSide(
                                        color: Colors.blue.shade900,
                                      )),
                                  groupValue: caseCategory,
                                  // tileColor: Colors.blue.shade100,
                                  title: Text("Suicidal"),
                                  onChanged: (value) {
                                    // print(value);
                                    setState(() {
                                      caseCategory = value!;
                                      onlineCheck = false;
                                    });
                                  }),
                        const SizedBox(height: 10,),
                        RadioListTile<CaseCategory>(
                            contentPadding: const EdgeInsets.all(0.0),
                            value: CaseCategory.Online,
                            dense: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                                side: BorderSide(
                                  color: Colors.blue.shade900,
                                )),
                            groupValue: caseCategory,
                            // tileColor: Colors.blue.shade100,
                            title: Text(CaseCategory.Online.name),
                            onChanged: (value) {
                              // print(value);
                              setState(() {
                                caseCategory = value!;
                                onlineCheck = true;
                              });
                            }),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              hasErrorMessage
                                  ? 'Please select a category'
                                  : '',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        onlineCheck
                            ? Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(36.0, 0, 0, 0),
                                child: DropdownButtonFormField(
                                    validator: (value) {
                                      if (onlineCheck) {
                                        if (value == null || value == "") {
                                          return ("Select option");
                                        }
                                        return null;
                                      }
                                      return null;
                                    },
                                    hint: Text(
                                      "Type of Online Abuse",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    icon: const Icon(Icons
                                        .arrow_drop_down_circle_outlined),
                                    elevation: 10,
                                    items: onlineList
                                        .map<DropdownMenuItem<String>>(
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
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == "") {
                              return ("Location required!");
                            }
                            return null;
                          },
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
                          keyboardType: TextInputType.phone,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == "") {
                              return ("Phone number required!");
                            } else if (value?.length != 10) {
                              return ("Invalid Phone number!");
                            }
                            return null;
                          },
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
                              labelText:
                                  "Optional: Describe the said incident",
                              prefixIcon: Icon(Icons.insert_comment_outlined),
                              isDense: true,
                              border: OutlineInputBorder()),
                        ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 100),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(35.5.w, 5.h),
                              backgroundColor: Colors.deepOrange,
                              elevation: 15,
                            ),
                            onPressed: () {
                              reportCase();
                            },
                            icon: Icon(
                              Icons.library_add_check,
                              size: 4.5.w,
                            ),
                            label: Text("Submit Report", style: TextStyle(fontSize: 3.w),),
                          ),
                        ),
                        const SizedBox(height: 50,),
                      ],
                    ),
                  );
                },
              ),
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

  void reportCase() async {
    var name = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    setState(() {
      hasErrorMessage = false;
    });
    try {
      if (_validate()) {
        setState(() {
          isLoading = true;
        });
        await connection.add({
          'user_id': userId!,
          'status': statusType!.name,
          'location': locationController.text,
          'phone': phoneController.text,
          'timestamp': DateTime.now(),
          'case_category': caseCategory!.name,
          'age': ageController.text,
          'online_category': dropdownValue,
          'comment': commentController.text,
          'handler': "CRI",
          'displayname': name.data()?['firstName'] +  ' ' + name.data()?['secondName'],

        });

        Fluttertoast.showToast(
            msg: "Report Submitted Successfully!",
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.grey,
            toastLength:Toast.LENGTH_LONG,
          textColor: Colors.white
        );
        Navigator.of(context).pop();
      } else
        setState(() {
          isLoading = false;
        });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message.toString(),
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.grey,
          toastLength: Toast.LENGTH_LONG);
    }
  }
}

