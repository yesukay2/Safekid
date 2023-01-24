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
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(10, 90, 10, 0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "I am a ___",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
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
                          onChanged: (val) {
                            setState(() {
                              statusType = val;
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
                          tileColor: Colors.deepOrange.shade100,
                          title: Text(StatusType.Witness.name),
                          onChanged: (val) {
                            setState(() {
                              statusType = val;
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
                  labelText: "Enter your Phone number:",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 95,
            ),
            ElevatedButton(
              onPressed: () {},
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
              child: const Text("Report"),
            )
          ],
        ),
      ),
    );
  }
}
