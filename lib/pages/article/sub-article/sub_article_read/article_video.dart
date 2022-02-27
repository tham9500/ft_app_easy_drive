import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/controller/article_test/video_car.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article_read/video_play/car.dart';
import 'package:shared_preferences/shared_preferences.dart';

class article_video extends StatefulWidget {
  const article_video({Key? key}) : super(key: key);

  @override
  _article_videoState createState() => _article_videoState();
}

class _article_videoState extends State<article_video> {
  String displayID = "";
  String status = "";

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
                image: status == "login"
                    ? DecorationImage(
                        image: AssetImage("assets/images/appbars/appbar1.png"),
                        fit: BoxFit.fill)
                    : DecorationImage(
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
      body: SingleChildScrollView(
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
                      image: AssetImage("assets/images/logo/article-read.png"),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  child: Center(
                    child: Text(
                      "คลิปท่าทางการสอบปฏิบัติ",
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(13, 59, 102, 1)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SubArticle_car(),
                SizedBox(height: 10),
                SubArticle_motorcycle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SubArticle_car() {
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
                      "คลิปท่าทางการสอบปฏิบัติ \nสำหรับรถยนต์",
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
              print("car article click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Car_video()));
            }));
  }

  Widget SubArticle_motorcycle() {
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
                      "คลิปท่าทางการสอบปฏิบัติ \nสำหรับรถจักรยานยนต์",
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
              print("games colors click");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => example_eyecolo()));
            }));
  }
}
