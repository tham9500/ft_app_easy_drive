import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/home.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_login.dart';

class History_charage extends StatefulWidget {
  History_charage({Key? key}) : super(key: key);

  @override
  _History_charageState createState() => _History_charageState();
}

class _History_charageState extends State<History_charage> {
  bool load = true;
  String displayID = "";
  String status = "";
  var history_data;

  List<dynamic> history = [];
  List<dynamic> date_his = [];
  List<dynamic> time_his = [];
  List<dynamic> day = [];
  List<dynamic> num_day = [];
  List<dynamic> month = [];
  List<dynamic> year = [];
  bool btn_s1 = true;
  bool btn_s2 = false;
  bool btn_s3 = false;

  void initState() {
    // TODO: implement initState
    super.initState();

    test();

    Check_status();
    //User_data();
    get_history();
  }

  test() {
    // DateTime now = DateTime.now();
    // String formattate = DateFormat('yyyy=MM=dd - kk:mm').format(now);
    // print("formattate = $formattate");

    DateTime testdate = DateTime.parse("2022-01-04 22:58:39");
    var convertdate =
        DateTime(testdate.year + 543, testdate.month, testdate.day);
    var convertTh = DateFormat.yMMMd().format(convertdate);
    print("convertdate = ${convertdate}");

    print("convertTh = ${convertTh}");
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
    get_history();
  }

  Future<void> get_history() async {
    Dio dio = new Dio();
    String url =
        "${Domain_name().domain}/easy_drive_backend/history_test/mobile/get_history.php?user_id=$displayID";

    var response = await Dio().get(url);
    try {
      // print("response history = ${response.toString()}");
      history = json.decode(response.data);
      if (history != null) {
        for (int i = 0; i < history.length; i++) {
          date_his.add(history[i]["test_date"].split(" ")[0]);
          time_his.add(history[i]["test_date"].split(" ")[1]);

          day.add(date_his[i].split("-")[2]);

          if (date_his[i].split("-")[1] == "01") {
            month.add("ม.ค");
          } else if (date_his[i].split("-")[1] == "02") {
            month.add("ก.พ");
          } else if (date_his[i].split("-")[1] == "03") {
            month.add("มี.ค");
          } else if (date_his[i].split("-")[1] == "04") {
            month.add("เม.ย");
          } else if (date_his[i].split("-")[1] == "05") {
            month.add("พ.ค");
          } else if (date_his[i].split("-")[1] == "06") {
            month.add("มิ.ย");
          } else if (date_his[i].split("-")[1] == "07") {
            month.add("ก.ค");
          } else if (date_his[i].split("-")[1] == "08") {
            month.add("ส.ค");
          } else if (date_his[i].split("-")[1] == "09") {
            month.add("ก.ย");
          } else if (date_his[i].split("-")[1] == "10") {
            month.add("ต.ค");
          } else if (date_his[i].split("-")[1] == "11") {
            month.add("พ.ย");
          } else if (date_his[i].split("-")[1] == "12") {
            month.add("ธ.ค");
          }
          // month.add(date_his[j].split("-")[1]);
          year.add(date_his[i].split("-")[0]);
        }

        print("list day = ${num_day.length}");
        print("list day = ${num_day}");

        setState(() {
          load = false;
        });
      } else {}
      // print("history_type = ${history.runtimeType}");
      // print("history_type = ${history.length}");
      print("history_type = ${history}");

      // print("date = ${date_his}");
      // print("time = ${time_his}");
      print("day = ${day}");
      print("month = ${month}");
      print("year = ${year}");
      check_day();
    } catch (e) {}
  }

  check_day() {
    num_day = day;
    print("AAAAAAAAAAAAAAAAA = ${day}");
    print("AAAAAAAAAAAAAAAAAAA = ${num_day.length}");

    for (int i = 0; i < num_day.length; i++) {
      print("num_day[i] = ${num_day[i]}");
      for (int j = 1; j < num_day.length; j++) {
        print("num_day[j] = ${num_day[j]}");
        if (num_day[i] != num_day[j]) {
          print("sssssssssssss");
          /* print(num_day[i] == num_day[j]); */
        } else {
          print("aaaaaaaaa");
          num_day.removeAt(j);
        }
      }
    }
    print("list day s = ${num_day.length}");
    print("list day s = ${num_day}");

    // DateTime testdate = DateTime.parse("2022-01-04 22:58:39");
    // var convertdate =
    //     DateTime(testdate.year + 543, testdate.month, testdate.day);
    // var convertTh = DateFormat.yMMMd().format(testdate).toString();
    // print("convertdate = ${convertdate}");

    // print("convertTh = $convertTh");
  }

  check_month() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "ประวัติการทำแบบทดสอบ",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              if (displayID == "") {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home_page()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home_login()));
              }
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
                    fit: BoxFit.cover),
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
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: history != null
                            ? page()
                            : CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget page() {
    return Container(
      child: Column(
        children: [
          Btn_day(),
          SizedBox(height: 15),
          btn_s1 == true
              ? list_day()
              : btn_s2 == true
                  ? list_week()
                  : list_month()
        ],
      ),
    );
  }

  Widget list_day() {
    return SingleChildScrollView(
      child: Container(
        child: ListView.builder(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical, //defualt
          shrinkWrap: true, //defualt
          itemCount: history.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                height: MediaQuery.of(context).size.height * 0.20,
                child: Card(
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Container(),
                      ],
                    ),
                  ),
                ),
              ),
              // color: Colors.amber.shade200,
            );
          },
        ),
      ),
    );
  }

  Widget list_week() {
    return SingleChildScrollView(
      child: Container(
        child: ListView.builder(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical, //defualt
          shrinkWrap: true, //defualt
          itemCount: history.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                height: MediaQuery.of(context).size.height * 0.20,
                child: Card(
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Text(
                                    "${history[index]["score"]}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: history[index]["result"] == "0"
                                      ? Colors.red
                                      : Colors.green.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(width: 15),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "วันที่ ${day[index]} ${month[index]} ${year[index]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      child: Text("${time_his[index]}",
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                child: Center(
                                  child: history[index]["result"] == "0"
                                      ? Text(
                                          "ไม่ผ่าน",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          "ผ่าน",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
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
              // color: Colors.amber.shade200,
            );
          },
        ),
      ),
    );
  }

  Widget list_month() {
    return SingleChildScrollView(
      child: Container(
        child: ListView.builder(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical, //defualt
          shrinkWrap: true, //defualt
          itemCount: history.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                height: MediaQuery.of(context).size.height * 0.20,
                child: Card(
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Text(
                                    "${history[index]["score"]}",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: history[index]["result"] == "0"
                                      ? Colors.red
                                      : Colors.green.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(width: 15),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "วันที่ ${day[index]} ${month[index]} ${year[index]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    Container(
                                      child: Text("${time_his[index]}",
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                child: Center(
                                  child: history[index]["result"] == "0"
                                      ? Text(
                                          "ไม่ผ่าน",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          "ผ่าน",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
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
              // color: Colors.amber.shade200,
            );
          },
        ),
      ),
    );
  }

  Widget Btn_day() {
    return Container(
      // padding: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      // height: 50,
      // width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color: Colors.amber.shade200,
      //   borderRadius: BorderRadius.circular(60),
      // ),
      child: Center(
        child: Row(
          children: <Widget>[
            SizedBox(width: 6),
            Container(
              width: 110,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: btn_s1 == true
                      ? MaterialStateProperty.all<Color>(
                          Colors.orangeAccent.shade400)
                      : MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Text("วัน", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  setState(() {
                    btn_s1 = true;
                    btn_s2 = false;
                    btn_s3 = false;
                  });
                  print("state 1");
                },
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 110,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: btn_s2 == true
                      ? MaterialStateProperty.all<Color>(
                          Colors.orangeAccent.shade400)
                      : MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Text(
                  "สัปดาห์",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    btn_s1 = false;
                    btn_s2 = true;
                    btn_s3 = false;
                  });
                  print("state 2");
                },
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 110,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: btn_s3 == true
                      ? MaterialStateProperty.all<Color>(
                          Colors.orangeAccent.shade400)
                      : MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Text("เดือน", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  setState(() {
                    btn_s1 = false;
                    btn_s2 = false;
                    btn_s3 = true;
                  });
                  print("state 3");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
