import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/video_aricle.dart';
import 'package:ft_app_easy_drive/pages/home.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home_article extends StatefulWidget {
  Home_article({Key? key}) : super(key: key);

  @override
  _Home_articleState createState() => _Home_articleState();
}

class _Home_articleState extends State<Home_article> {
  bool load = true;
  String displayID = "";
  String status = "";
  List<dynamic> list_cate = [];
  List<dynamic> result = [];
  String id_cate = "";
  String name_cate = "";

  String _url = '';

  void initState() {
    // TODO: implement initState
    super.initState();

    Check_status();
    get_Cate();
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

  Future<Null> get_Cate() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/category/mobile/get_category.php';

    var response = await Dio().get(url);

    try {
      if (status == "login") {
        list_cate = json.decode(response.data);
      } else if (status == "logout") {
        result = json.decode(response.data);
        for (int i = 0; i < result.length; i++) {
          if (result[i]["cate_show"] == "0") {
            list_cate.add(result[i]);
          } else {}
        }
      }
      print("listcate filter= ${list_cate.length}");
      print("listcate filter= ${list_cate}");

      setState(() {
        load = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
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
                            image: AssetImage("assets/images/logo/article.png"),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        child: Center(
                          child: Text(
                            "เกี่ยวกับใบขับขี่",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(13, 59, 102, 1)),
                          ),
                        ),
                      ),
                      List_cate(),
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
        itemCount: list_cate.length,

        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Padding(
                padding: const EdgeInsets.all(4),
                child: list_cate[index]["cate_type"] == "V"
                    ? Video_cate(index)
                    : list_cate[index]["cate_type"] == "L"
                        ? Link_cate(index)
                        : Article_cate(index)
                // color: Colors.amber.shade200,
                ),
          );
        },
      ),
    );
  }

  Widget Link_cate(index) {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(230, 238, 246, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/logo/article-fee.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text(
                      "${list_cate[index]["cate_name"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              setState(() {
                id_cate = list_cate[index]["cate_id"];
                name_cate = list_cate[index]["cate_name"];
                _url = list_cate[index]["link"];
                // _url = 'https://flutterdevs.com/';
              });
              check_link();
              cateService();
            }));
  }

  Widget Video_cate(index) {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(230, 238, 246, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/logo/article-doc.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text(
                      "${list_cate[index]["cate_name"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              setState(() {
                id_cate = list_cate[index]["cate_id"];
                name_cate = list_cate[index]["cate_name"];
              });
              cateService();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Video_aricle()));
            }));
  }

  Widget Article_cate(index) {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(230, 238, 246, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image:
                            AssetImage("assets/images/logo/article-read.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text(
                      "${list_cate[index]["cate_name"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              setState(() {
                id_cate = list_cate[index]["cate_id"];
                name_cate = list_cate[index]["cate_name"];
              });
              cateService();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Sub_article()));
            }));
  }

  Future<Null> cateService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('CATERGORY_ID', id_cate);
    preferences.setString('CATERGORY_NAME', name_cate);
    print("ID_CATE = $id_cate");
    print("NAME_CATE = $name_cate");
  }

  check_link() {
    if (_url != '') {
      _launchURL();
    } else {
      print("Url id empty");
    }
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw "could not launch $_url";
}
