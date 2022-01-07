import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/controller/article_test/article_sign.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/comment_article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article_read/article_sign.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Content extends StatefulWidget {
  Content({Key? key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  bool load = true;
  String displayID = "";
  String status = "";
  String articleCate_id = "";
  String articleCate_name = "";
  List<dynamic> list_content = [];
  String article_ID = "";
  String article_NAME = "";
  String article_HEAD = "";

  @override
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
      article_ID = preferences.getString("ARTICLE_ID")!;
      article_NAME = preferences.getString("ARTICLE_NAME")!;
      article_HEAD = preferences.getString("ARTICLE_HEAD")!;
    });
    print("ID_article = ${article_ID}");
    get_article();
    // print("ID = ${cate_name}");
  }

  Future<Null> get_article() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/content/mobile/get_content.php?article_id=$article_ID';

    var response = await Dio().get(url);
    print(response);
    try {
      list_content = json.decode(response.data);
      print("list_article = ${list_content.length}");
      print("list_article = ${list_content}");
      setState(() {
        load = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.data);
    //print(widget.data[0]["sub_article"]);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "${article_HEAD}".length > 30
                ? "${article_HEAD}".substring(0, 30) + "..."
                : "${article_HEAD}",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
                children: <Widget>[],
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
          :
          //child: Text("${widget.data[0]["sub_article"]}"),
          Align(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      //First_page(),
                      Container(
                        height: MediaQuery.of(context).size.height * 1.25,
                        child: PageView.builder(
                          itemCount: list_content.length,
                          itemBuilder: (context, index) {
                            print(list_content[index]);
                            return Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child:
                                        list_content[index] == list_content[0]
                                            ? First_page(index)
                                            : Next_page(index),
                                  ),
                                  Comment_article()
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget Comment_article() {
    return Container(
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
        backgroundColor: Colors.amberAccent.shade700,
        child: Icon(Icons.chat),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Comment_articl()));
        },
      ),
    );
  }

  Widget First_page(index) {
    return Container(
      child: Column(
        children: <Widget>[
          // Container(
          //   child: Text(
          //     "${widget.data["head"]}",
          //     style: TextStyle(
          //         color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              "${article_HEAD}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            child: list_content[index]['image_content'] != null
                ? Image_article(index)
                : Empty_image(),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              "${list_content[index]['text_content']}",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget Next_page(index) {
    return Container(
      child: Column(
        children: [
          Container(
            child: list_content[index]['image_content'] != null
                ? Image_article(index)
                : Empty_image(),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "${list_content[index]['text_content']}",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget Empty_image() {
    return Container(
        // child: Text(
        //   "${list_text[index]['text']}",
        //   style: TextStyle(fontSize: 18),
        // ),
        );
  }

  Widget Image_article(index) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        child: Image.network(
          "${Domain_name().domain}/easy_drive_backend/image/article/${list_content[index]["image_content"]}",
          width: 400,
          height: 200,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: LinearProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
        onTap: () {
          zoomPictureDialog(context,
              "${Domain_name().domain}/easy_drive_backend/image/article/${list_content[index]["image_content"]}");
        },
      ),
    );
  }

  Future<void> zoomPictureDialog(BuildContext context, url) async {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      // transitionDuration: const Duration(
      //     milliseconds:
      //         400), // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // Makes widget fullscreen
        return Stack(
          children: [
            Container(
              child: SizedBox.expand(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: SizedBox.expand(
                        child: Center(
                          child: InteractiveViewer(
                            panEnabled: true, // Set it to false
                            boundaryMargin: const EdgeInsets.all(100),
                            minScale: 0.5,
                            maxScale: 2,
                            // child: Image.file(
                            //   file,
                            //   width: MediaQuery.of(context).size.width,
                            //   height: MediaQuery.of(context).size.height,
                            //   fit: BoxFit.cover,
                            // ),
                            child: Image.network(
                              url,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 15.0,
              top: 60.0,
              child: TextButton(
                child: const Text(
                  'ปิด',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                onPressed: () => Navigator.pop(context, true),
              ),
            ),
          ],
        );
      },
    );
  }
}
