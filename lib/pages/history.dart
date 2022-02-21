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
  String type_filter = "";

  List<dynamic> history = [];
  List<dynamic> date_his = [];
  List<dynamic> date_th = [];
  List<dynamic> time_his = [];
  List<dynamic> _hour = [];
  List<dynamic> _min = [];
  List<dynamic> num_day = [];
  List<dynamic> month = [];
  List<dynamic> year = [];
  bool btn_s1 = true;
  bool btn_s2 = false;
  bool btn_s3 = false;

  void initState() {
    // TODO: implement initState
    super.initState();

    Check_status();
    User_data();
    get_history();
  }

  convert_Datetime() {
    for (int i = 0; i < history.length; i++) {
      DateTime testdate = DateTime.parse("${date_his[i]}");

      var convertdate =
          DateTime(testdate.year + 543, testdate.month, testdate.day);
      String convertTh = DateFormat.yMMMd().format(convertdate);
      print("convertdate = ${convertdate}");
      date_th.add(convertTh);
      print("convertTh = ${convertTh}");
    }
    print("date th = ${date_th.length}");
    print("date th = ${date_th}");

    setState(() {
      load = false;
    });
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
    filter_history();
  }

  filter_history() {
    if (btn_s1 == true) {
      type_filter = "week";
      print("preset = week");
      get_history();
    } else if (btn_s2 == true) {
      type_filter = "month";
      print("preset = month");
      get_history();
    } else if (btn_s3 == true) {
      type_filter = "month6";
      print("preset = month6");
      get_history();
    }
  }

  Future<void> get_history() async {
    Dio dio = new Dio();
    String url =
        "${Domain_name().domain}/easy_drive_backend/history_test/mobile/get_history.php?user_id=$displayID&filter=$type_filter";

    var response = await Dio().get(url);
    print("response = ${response.toString()}");
    try {
      history = json.decode(response.data);
      if (history != null) {
        for (int i = 0; i < history.length; i++) {
          date_his.add(history[i]["test_date"].split(" ")[0]);
          time_his.add(history[i]["test_date"].split(" ")[1]);
        }
        for (int j = 0; j < time_his.length; j++) {
          _hour.add(time_his[j].split(":")[0]);
          _min.add(time_his[j].split(":")[1]);
        }
        // print("hr = ${_hour}");
        // print("min = ${_min}");
        convert_Datetime();
      } else {}

      print("history_type = ${history}");
    } catch (e) {}
  }

  remove_list() {
    history.removeRange(0, history.length);
    date_his.removeRange(0, date_his.length);
    date_th.removeRange(0, date_th.length);
    time_his.removeRange(0, time_his.length);
    _hour.removeRange(0, _hour.length);
    _min.removeRange(0, _min.length);
    print("List remove = ${history.length}");
    print("List remove = ${date_his.length}");
    print("List remove = ${date_th.length}");
  }

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
                  padding: const EdgeInsets.all(4),
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
          btn_s1 == true
              ? list_week()
              : btn_s2 == true
                  ? list_month()
                  : list_6month()
        ],
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
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.15,
                child: Card(
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  //score
                                  child: Text(
                                    "${history[index]["score"]}/${history[index]["max_score"]}",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.27,
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                decoration: BoxDecoration(
                                  //pass & fail color
                                  color: history[index]["result"] == "0"
                                      ? Colors.red
                                      : Colors.green.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    //date
                                    Container(
                                      child: Text(
                                        "วันที่ ${date_th[index]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    //time
                                    Container(
                                      child: Text(
                                          "เวลา ${_hour[index]}:${_min[index]}",
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                child: Center(
                                  //condition word pass and fail
                                  child: history[index]["result"] == "0"
                                      ? Text(
                                          "ไม่ผ่าน",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          "ผ่าน",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
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
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.15,
                child: Card(
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  //score
                                  child: Text(
                                    "${history[index]["score"]}/${history[index]["max_score"]}",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.27,
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                decoration: BoxDecoration(
                                  //pass & fail color
                                  color: history[index]["result"] == "0"
                                      ? Colors.red
                                      : Colors.green.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    //date
                                    Container(
                                      child: Text(
                                        "วันที่ ${date_th[index]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    //time
                                    Container(
                                      child: Text(
                                          "เวลา ${_hour[index]}:${_min[index]}",
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                child: Center(
                                  //condition word pass and fail
                                  child: history[index]["result"] == "0"
                                      ? Text(
                                          "ไม่ผ่าน",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          "ผ่าน",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
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
            );
          },
        ),
      ),
    );
  }

  Widget list_6month() {
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
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.15,
                child: Card(
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  //score
                                  child: Text(
                                    "${history[index]["score"]}/${history[index]["max_score"]}",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.27,
                                height:
                                    MediaQuery.of(context).size.height * 0.10,
                                decoration: BoxDecoration(
                                  //pass & fail color
                                  color: history[index]["result"] == "0"
                                      ? Colors.red
                                      : Colors.green.shade400,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    //date
                                    Container(
                                      child: Text(
                                        "วันที่ ${date_th[index]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    //time
                                    Container(
                                      child: Text(
                                          "เวลา ${_hour[index]}:${_min[index]}",
                                          style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                child: Center(
                                  //condition word pass and fail
                                  child: history[index]["result"] == "0"
                                      ? Text(
                                          "ไม่ผ่าน",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        )
                                      : Text(
                                          "ผ่าน",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 20,
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
            );
          },
        ),
      ),
    );
  }

  Widget Btn_day() {
    return Container(
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
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
                child: Text("สัปดาห์", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  setState(() {
                    btn_s1 = true;
                    btn_s2 = false;
                    btn_s3 = false;
                  });
                  load = true;
                  filter_history();
                  remove_list();
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
                  "เดือน",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    btn_s1 = false;
                    btn_s2 = true;
                    btn_s3 = false;
                  });
                  load = true;
                  filter_history();
                  remove_list();
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
                child: Text("6 เดือน", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  setState(() {
                    btn_s1 = false;
                    btn_s2 = false;
                    btn_s3 = true;
                  });
                  load = true;
                  filter_history();
                  remove_list();
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
