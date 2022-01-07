import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article_read/content.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Comment_articl extends StatefulWidget {
  Comment_articl({Key? key}) : super(key: key);

  @override
  _Comment_articlState createState() => _Comment_articlState();
}

class _Comment_articlState extends State<Comment_articl> {
  bool load = true;
  String displayID = "";
  String status = "";
  String id_article = "";
  String name_article = "";
  String comment = "";
  int score = 0;
  bool p1 = false;
  bool p2 = false;
  bool p3 = false;
  bool p4 = false;
  bool p5 = false;
  final form_key = GlobalKey<FormState>();
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
    article_data();
  }

  Future<Null> article_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_article = preferences.getString("ARTICLE_ID")!;
      name_article = preferences.getString("ARTICLE_NAME")!;
    });
    print("ID_article = ${id_article}");
    // print("ID = ${cate_name}");
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
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: form_key,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ชื่อบทความ : ${name_article}",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Score(),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "แสดงความคิดเห็น",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  form_comment(),
                  SizedBox(height: 20),
                  Btn_StateSubmit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Btn_StateSubmit() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            child: Text(
              "ส่งความคิดเห็น",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              print("submit click");
              form_key.currentState!.save();
              if (score == 0) {
                _showMyDialogWorking(
                    "กรุณาให้คะแนนก่อน\nทำการส่งแสดงความคิดเห็น");
              } else {
                print("comment complete");
                Send_comment();
              }

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Registor_page()));
            }));
  }

  Future<void> _showMyDialogWorking(content) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Container(
                    child: Text(
                      "${content}",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: TextButton(
                      child: const Text(
                        'ตกลง',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      onPressed: () {
                        if (content ==
                            "กรุณาให้คะแนนก่อน\nทำการส่งแสดงความคิดเห็น") {
                          Navigator.pop(context, true);
                        } else if (content == "ขอบคุณที่แสดงความคิดเห็น") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Content()));
                        } else if (content == "ส่งความคิดเห็นไม่สำเร็จ") {
                          Navigator.pop(context, true);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> Send_comment() async {
    Dio dio = new Dio();
    String url =
        "${Domain_name().domain}/easy_drive_backend/comment/mobile/add_comment.php?user_id=$displayID&article_id=$id_article";
    var dataReq = {};

    dataReq["rate"] = score;
    dataReq["comment"] = comment;

    String data = jsonEncode(dataReq);
    var response = await Dio().post(url, data: data);

    try {
      print(response);
      print("res = ${response.toString()}");
      print("return = ${response}");
      if (response.toString() == "complete") {
        _showMyDialogWorking("ขอบคุณที่แสดงความคิดเห็น");
      } else if (response.toString() == "error") {
        _showMyDialogWorking("ส่งความคิดเห็นไม่สำเร็จ");
      }
    } catch (e) {}
  }

  Widget Score() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: IconButton(
              icon: Icon(Icons.star,
                  color: p1 == true ? Colors.yellow.shade700 : Colors.grey,
                  size: 40),
              onPressed: () {
                setState(() {
                  p1 = true;
                  p2 = false;
                  p3 = false;
                  p4 = false;
                  p5 = false;
                  score = 1;
                });
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.star,
                  color: p2 == true ? Colors.yellow.shade700 : Colors.grey,
                  size: 40),
              onPressed: () {
                setState(() {
                  p1 = true;
                  p2 = true;
                  p3 = false;
                  p4 = false;
                  p5 = false;
                  score = 2;
                });
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.star,
                  color: p3 == true ? Colors.yellow.shade700 : Colors.grey,
                  size: 40),
              onPressed: () {
                setState(() {
                  p1 = true;
                  p2 = true;
                  p3 = true;
                  p4 = false;
                  p5 = false;
                  score = 3;
                });
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.star,
                  color: p4 == true ? Colors.yellow.shade700 : Colors.grey,
                  size: 40),
              onPressed: () {
                setState(() {
                  p1 = true;
                  p2 = true;
                  p3 = true;
                  p4 = true;
                  p5 = false;
                  score = 4;
                });
              },
            ),
          ),
          Container(
            child: IconButton(
              icon: Icon(Icons.star,
                  color: p5 == true ? Colors.yellow.shade700 : Colors.grey,
                  size: 40),
              onPressed: () {
                setState(() {
                  p1 = true;
                  p2 = true;
                  p3 = true;
                  p4 = true;
                  p5 = true;
                  score = 5;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget form_comment() {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        minLines: 1,
        maxLines: 5,
        onChanged: (value) => setState(() {
          comment = value;
        }),
      ),
    );
  }
}
