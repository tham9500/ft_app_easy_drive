import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/load_example/load_example.dart';
import 'package:ft_app_easy_drive/pages/history.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guide_charange extends StatefulWidget {
  Guide_charange({Key? key}) : super(key: key);

  @override
  _Guide_charangeState createState() => _Guide_charangeState();
}

class _Guide_charangeState extends State<Guide_charange> {
  bool load = true;
  int timerMaxSeconds = 0;
  final int timerMaxMinute = 0;
  String displayID = "";
  String status = "";
  int currentSeconds = 0;
  int currentMinute = 0;
  List<dynamic> setting_list = [];
  int pass = 0;
  int score = 0;
  int maxScore = 0;
  int h = 0, m = 0;
  String result = "";
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
    get_setting();
  }

  Future<Null> get_setting() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/exam_setting/mobile/get_setting.php';

    var response = await Dio().get(url);
    var data_setting = json.decode(response.data);
    setting_list = data_setting;
    print("data : ${setting_list}");
    pass = int.parse(setting_list[0]["pass_criteria"]);
    maxScore = int.parse(setting_list[0]["num_test"]);
    timerMaxSeconds = int.parse(setting_list[0]["set_time"]);
    print(timerMaxSeconds);
    intToTimeLeft();
    
  }

  intToTimeLeft() {
    h = timerMaxSeconds ~/ 3600;

    m = ((timerMaxSeconds - h * 3600)) ~/ 60;
    if (h > 1) {
      result = "$h : $m ชั่วโมง";
    } else if (h < 1) {
      result = "${m} นาที";
    }

    print(result);
    setState(() {
      load = false;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_login()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/appbars/appbar.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // title: Text(
          //   "ลงทะเบียนเข้าใช้งาน",
          //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
        ),
      ),
      body: load
          ? ShowProgress()
          : SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/images/logo/charange.png"),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        child: Center(
                          child: Text(
                            "แบบทดสอบ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(13, 59, 102, 1)),
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                      Container(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Btn_History(),
                              SizedBox(width: 20),
                              Btn_Start(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ข้อกำหนดก่อนเริ่มทำแบบทดสอบ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/game_icon/notification4.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "การทดสอบโดยมีการจับเวลา\n${result}",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/game_icon/notification5.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "การทดสอบจะเป็นการสุ่มเลือก\nทั้งหมด ${setting_list[0]["num_test"]} ข้อ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/game_icon/notification6.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "การทดสอบเป็นการจำลองเท่านั้น\nและไม่มีผลต่อการสอบจริง",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                //color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/game_icon/exit.png"),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "หากกดออกหรือปิดแอพพลิเคชัน\nระหว่างสอบ การสอบจะสิ้นสุดลง",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget test() {
    return Container();
  }

  Widget Btn_Start() {
    return Container(
        height: 50,
        width: 150,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange.shade800),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ))),
            child: Text(
              "เริ่ม",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              print("Submit click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Load_example()));
            }));
  }

  Widget Btn_History() {
    return Container(
        height: 50,
        width: 150,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ))),
            child: Text(
              "ประวัติ",
              style: TextStyle(fontSize: 16, color: Colors.orange.shade700),
            ),
            onPressed: () {
              print("Submit click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => History_charage()));
            }));
  }
}
