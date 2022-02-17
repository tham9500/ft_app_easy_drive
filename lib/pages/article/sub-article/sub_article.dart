import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/article/home_article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article_read/article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article_read/article_sign.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sub_article extends StatefulWidget {
  Sub_article({Key? key}) : super(key: key);

  @override
  _Sub_articleState createState() => _Sub_articleState();
}

class _Sub_articleState extends State<Sub_article> {
  bool load = true;
  String displayID = "";
  String status = "";
  String cate_id = "";
  String cate_name = "";
  String id_articleCate = "";
  String name_articleCate = "";
  List<dynamic> list_articleCate = [];

  void initState() {
    // TODO: implement initState
    super.initState();

    Check_status();
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
      Cate_data();
    }
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayID = preferences.getString("ID")!;
    });
    print("ID = ${displayID}");
    Cate_data();
  }

  Future<Null> Cate_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      cate_id = preferences.getString("CATERGORY_ID")!;
      cate_name = preferences.getString("CATERGORY_NAME")!;
    });
    print("ID_cate = ${cate_id}");
    get_articleCate();
    // print("ID = ${cate_name}");
  }

  Future<Null> get_articleCate() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/article_cate/mobile/get_article_cate.php?cate_id=$cate_id';

    var response = await Dio().get(url);

    try {
      list_articleCate = json.decode(response.data);
      print("list_cate = ${list_articleCate.length}");
      print("list_cate = ${list_articleCate}");
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
                    MaterialPageRoute(builder: (context) => Home_article()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home_article()));
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
                            image: AssetImage(
                                "assets/images/logo/article-read.png"),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        child: Center(
                          child: Text(
                            "${cate_name}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromRGBO(13, 59, 102, 1)),
                          ),
                        ),
                      ),
                      List_articlecate(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget List_articlecate() {
    return Container(
      child: ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical, //defualt
        shrinkWrap: true, //defualt
        itemCount: list_articleCate.length,

        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Article_cate(index),
              // color: Colors.amber.shade200,
            ),
          );
        },
      ),
    );
  }

  Widget SubArticle_sign() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

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
                      "เครื่องหมายจราจร",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Article_sign()));
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
                  Color.fromRGBO(255, 255, 255, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 260,
                    child: Text(
                      "${list_articleCate[index]["article_cate_name"]}".length >
                              30
                          ? "${list_articleCate[index]["article_cate_name"]}"
                                  .substring(0, 30) +
                              " ..."
                          : "${list_articleCate[index]["article_cate_name"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                id_articleCate = list_articleCate[index]["article_cate_id"];
                name_articleCate = list_articleCate[index]["article_cate_name"];
              });
              cateService();
              print("games colors click");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Article()));
            }));
  }

  Future<Null> cateService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('aCATE_ID', id_articleCate);
    preferences.setString('aCATE_NAME', name_articleCate);
    print("ID_CATE = $id_articleCate");
    print("NAME_CATE = $name_articleCate");
  }
}
