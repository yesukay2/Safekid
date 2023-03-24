import 'package:flutter/material.dart';
import 'library.dart';


class cases_Page extends StatefulWidget {
  const cases_Page({Key? key}) : super(key: key);

  @override
  State<cases_Page> createState() => _cases_PageState();
}

class _cases_PageState extends State<cases_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: Image.asset(
          "lib/images/logo-removebg-preview.jpg",
          fit: BoxFit.contain,
          height: 10,
        ),
        leadingWidth: 100,
        title: const Text(
          "My Cases",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body:

          Center(child: Container(child: UserRecordsWidget()))

    );
  }
}
