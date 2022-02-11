import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/guide_charange.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/screen_example/view_uncorrect.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class End_test extends StatefulWidget {
  End_test({Key? key}) : super(key: key);

  @override
  State<End_test> createState() => _End_testState();
}

class _End_testState extends State<End_test> {
  List<dynamic> list_show = [];
  String condition = "";
  int maxScore = 0;
  String displayID = "";
  String status = "";

  void initState() {
    // startTimeout();
    super.initState();
    Check_status();
    // Quiz_charage();
    // Choice();
  }

  Future<Null> Check_status() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      String list_data = preferences.getString("LIST_QUIZ")!;
      list_show = jsonDecode(list_data);
      maxScore = preferences.getInt("MAX_SCORE")!;
      condition = preferences.getString("CONDITION")!;
      status = preferences.getString("STATUS")!;
    });
    if (status == "login") {
      print("login complete");
      User_data();
    } else {
      print("Not login");
    }
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayID = preferences.getString("ID")!;
    });
    print("ID = ${displayID}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: status == "pass"
                      ? Colors.lightGreen.shade400
                      : Colors.red.shade700,
                  shape: BoxShape.circle,
                ),
                child: status == "pass"
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 128,
                      )
                    : Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 128,
                      ),
              ),
              SizedBox(height: 10),
              Container(
                child: status == "pass"
                    ? Text(
                        "ผ่าน",
                        style: TextStyle(
                            fontSize: 48, color: Colors.green.shade500),
                      )
                    : Text(
                        "ไม่ผ่าน",
                        style:
                            TextStyle(fontSize: 48, color: Colors.red.shade700),
                      ),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Btn_again(),
                    SizedBox(width: 30),
                    Btn_back(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Btn_view()
            ],
          ),
        ),
      ),
    );
  }

  Widget Btn_again() {
    return Container(
        height: 50,
        width: 150,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            child: status == "pass"
                ? Text(
                    "เริ่มใหม่",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(95, 206, 47, 1)),
                  )
                : Text(
                    "เริ่มใหม่",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
            onPressed: () {
              print("registor click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Guide_charange()));
            }));
  }

  Widget Btn_back() {
    return Container(
        height: 50,
        width: 150,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: status == "pass"
                    ? MaterialStateProperty.all<Color>(
                        Color.fromRGBO(95, 206, 47, 1))
                    : MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ))),
            child: Text(
              "กลับสู่หน้าจอหลัก",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              print("login click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_login()));
            }));
  }

  Widget Btn_view() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: status == "pass"
                    ? MaterialStateProperty.all<Color>(
                        Color.fromRGBO(95, 206, 47, 1))
                    : MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ))),
            child: Text(
              "ดูเฉลยข้อที่คำตอบไม่ถูกต้อง",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              print("login click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => View_uncorrect()));
            }));
  }
}
