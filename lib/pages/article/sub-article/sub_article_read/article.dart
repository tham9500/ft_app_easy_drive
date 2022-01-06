import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/controller/article_test/article_sign.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/show_article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Article extends StatefulWidget {
  Article({Key? key}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  bool load = true;
  String displayID = "";
  String status = "";
  String articleCate_id = "";
  String articleCate_name = "";
  List<dynamic> list_article = [];
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
    }
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayID = preferences.getString("ID")!;
    });
    print("ID = ${displayID}");
    articleCate_data();
  }

  Future<Null> articleCate_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      articleCate_id = preferences.getString("aCATE_ID")!;
      articleCate_name = preferences.getString("aCATE_NAME")!;
    });
    print("ID_article = ${articleCate_id}");
    get_article();
    // print("ID = ${cate_name}");
  }

  Future<Null> get_article() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/article/mobile/get_article.php?article_cate_id=$articleCate_id';

    var response = await Dio().get(url);

    try {
      list_article = json.decode(response.data);
      print("list_article = ${list_article.length}");
      print("list_article = ${list_article}");
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
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "${articleCate_name}".length > 30
                ? "${articleCate_name}".substring(0, 30) + "..."
                : "${articleCate_name}",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      List_article(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget List_article() {
    return Container(
      child: ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical, //defualt
        shrinkWrap: true, //defualt
        itemCount: list_article.length,

        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: article(index),
              // color: Colors.amber.shade200,
            ),
          );
        },
      ),
    );
  }

  Widget article(index) {
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
                    padding: const EdgeInsets.all(8),
                    width: 260,
                    child: Text(
                      "${list_article[index]["article_title"]}".length > 30
                          ? "${list_article[index]["article_title"]}"
                              .substring(0, 30)
                          : "${list_article[index]["article_title"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                // id_articleCate = list_articleCate[index]["article_cate_id"];
                // name_articleCate = list_articleCate[index]["article_cate_name"];
              });
              // cateService();
              print("read article click");
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => Article()));
            }));
  }
}
