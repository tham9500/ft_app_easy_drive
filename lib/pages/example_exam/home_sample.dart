import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/example_exam/screen_example.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home_sample extends StatefulWidget {
  home_sample({Key? key}) : super(key: key);

  @override
  _home_sampleState createState() => _home_sampleState();
}

class _home_sampleState extends State<home_sample> {
  bool load = true;
  String displayID = "";
  String status = "";
  String id_article_cate_id = "";
  List<dynamic> list_example = [];

  void initState() {
    // TODO: implement initState
    super.initState();

    Check_status();
    get_example();
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
  }

  Future<Null> get_example() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/test/mobile/get_article_cate_answer.php';

    var response = await Dio().get(url);
    var data_example = json.decode(response.data);
    list_example = data_example;
    print("data : ${data_example}");
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
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
                    image: AssetImage("assets/images/appbars/appbar1.png"),
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
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/logo/article_charange.png"),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        child: Center(
                          child: Text(
                            "แนวข้อสอบ",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(13, 59, 102, 1)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      List_cate()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget List_cate() {
    return Container(
      child: ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical, //defualt
        shrinkWrap: true, //defualt
        itemCount: list_example.length,

        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: data_list(index),
            // color: Colors.amber.shade200,
          );
        },
      ),
    );
  }

  Widget data_list(index) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(4),
      // color: Colors.amber.shade200,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(255, 255, 255, 1),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        child: Container(
          child: Row(
            children: <Widget>[
              SizedBox(width: 12),
              Container(
                width: 260,
                child: Text(
                  "${list_example[index]["article_cate_name"]}",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          setState(() {
            id_article_cate_id = list_example[index]["article_cate_id"];
          });
          print("games colors click");
          cateService();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Screen_example()));
        },
      ),
    );
  }

  Future<Null> cateService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ID_ARTICLE_CATE_ID', id_article_cate_id);
    print("ID_ACI = $id_article_cate_id");
  }
}
