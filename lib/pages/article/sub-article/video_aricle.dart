import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/article/home_article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article_read/video_play/play_video.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Video_aricle extends StatefulWidget {
  Video_aricle({Key? key}) : super(key: key);

  @override
  _Video_aricleState createState() => _Video_aricleState();
}

class _Video_aricleState extends State<Video_aricle> {
  bool load = true;
  String displayID = "";
  String status = "";
  String cate_id = "";
  String cate_name = "";
  String id_video = "";
  String name_video = "";
  String head_video = "";
  String file_video = "";
  List<dynamic> list_video = [];
  List<dynamic> result = [];

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
    get_Video();
    // print("ID = ${cate_name}");
  }

  Future<Null> get_Video() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/videoo/mobile/get_video.php?cate_id=$cate_id';

    var response = await Dio().get(url);

    try {
      list_video = json.decode(response.data);

      print("listcate filter= ${list_video.length}");
      print("listcate filter= ${list_video}");

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_article()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "${cate_name}".length > 30
                ? "${cate_name}".substring(0, 30) + "..."
                : "${cate_name}",
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
                      Container(
                        child: list_video.length == 0
                            ? Empty_list()
                            : List_video(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget Empty_list() {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text("ไม่มีรายการที่แดสง"),
        ),
      ),
    );
  }

  Widget List_video() {
    return Container(
      child: ListView.builder(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical, //defualt
        shrinkWrap: true, //defualt
        itemCount: list_video.length,

        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: video(index),
              // color: Colors.amber.shade200,
            ),
          );
        },
      ),
    );
  }

  Widget video(index) {
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
                      "${list_video[index]["video_name"]}".length > 30
                          ? "${list_video[index]["video_name"]}"
                              .substring(0, 30)
                          : "${list_video[index]["video_name"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                id_video = list_video[index]["video_id"];
                name_video = list_video[index]["video_name"];
                head_video = list_video[index]["video_head"];
                file_video = list_video[index]["video"];
              });
              cateService();
              // cateService();
              print("read article click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Play_video()));
            }));
  }

  Future<Null> cateService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('VIDEO_ID', id_video);
    preferences.setString('VIDEO_NAME', name_video);
    preferences.setString('VIDEO_HEAD', head_video);
    preferences.setString('VIDEO_FILE', file_video);
    print("ID_VIDEO = $id_video");
    print("NAME_VIDEO = $name_video");
    print("HEAD_VIDEO = $head_video");
    print("FILE_VIDEO = $file_video");
  }
}
