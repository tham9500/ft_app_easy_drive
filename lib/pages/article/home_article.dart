import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article_read/article_video.dart';
import 'package:ft_app_easy_drive/pages/home.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home_article extends StatefulWidget {
  Home_article({Key? key}) : super(key: key);

  @override
  _Home_articleState createState() => _Home_articleState();
}

class _Home_articleState extends State<Home_article> {
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
      body: Container(
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
                        fontSize: 18, color: Color.fromRGBO(13, 59, 102, 1)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Article_video(),
              SizedBox(height: 20),
              Article_fee(),
              SizedBox(height: 20),
              Article_doc(),
              SizedBox(height: 20),
              Article_read(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Article_fee() {
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
                      "ค่าธรรมเนียบการสอบ",
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

  Widget Article_doc() {
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
                      "วิธีการสอบและ\nเอกสารที่จำเป็น",
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

  Widget Article_video() {
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
                      "คลิปท่าทางการสอบปฏิบัติ",
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => article_video()));
            }));
  }

  Widget Article_read() {
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
                      "รอบรู้เรื่องการขับขี่",
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Sub_article()));
            }));
  }
}
