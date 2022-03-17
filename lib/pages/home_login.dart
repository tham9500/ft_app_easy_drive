import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/article/home_article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/guide_charange.dart';
import 'package:ft_app_easy_drive/pages/example_exam/home_sample.dart';
import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';
import 'package:ft_app_easy_drive/pages/history.dart';
import 'package:ft_app_easy_drive/pages/login.dart';
import 'package:ft_app_easy_drive/pages/pageSample.dart';
import 'package:ft_app_easy_drive/pages/profile.dart';
import 'package:ft_app_easy_drive/pages/registor.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home_login extends StatefulWidget {
  Home_login({Key? key}) : super(key: key);

  @override
  _Home_loginState createState() => _Home_loginState();
}

class _Home_loginState extends State<Home_login> {
  //user data
  bool load = true;
  String displayName = "";
  String displayID = "";
  //data save history
  String history = "";
  //data url open
  String _url = '';
  //data open article main
  String id_cate = "1641395148";
  String name_cate = "รอบรู้เรื่องขับขี่";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User_data();
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayName = preferences.getString("FIRSTNAME")!;
      displayID = preferences.getString("ID")!;
    });
    print("login complete");
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false, //move back button

          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20, top: 15),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                    onPressed: () {
                      //save history
                      history = "E";
                      User_history();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile_user()));
                    },
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.orange.shade700,
                      size: 30,
                    )),
              ),
            ),
          ],

          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/appbars/appbar1.png"),
                    fit: BoxFit.fill),
              ),
              padding: EdgeInsets.all(35),
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
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(height: 25),
                                      Container(
                                        child: Text(
                                          "ยินดีต้อนรับ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Show_username()
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
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
          : Scrollbar(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        //menu scroll horizantal
                        Scroll_Article_horizon(),
                        SizedBox(height: 20),
                        //main menu
                        Scroll_menu(),
                        SizedBox(height: 20),
                        //list menu title
                        tittle_menu(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget tittle_menu() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "สำหรับคุณ",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            //article example
            article_charange(),
            SizedBox(height: 20),
            //history widget
            history_charange(),
            // SizedBox(height: 20),
            // //history widget
            // test(),
          ],
        ),
      ),
    );
  }

  Widget Scroll_menu() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  //widget open game page
                  Games_Page(),
                  SizedBox(width: 20),
                  //wiget open article page
                  Article_Page(),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Row(
                children: <Widget>[
                  //wiget open charage page
                  Charage_Page(),
                  SizedBox(width: 20),
                  // Article_Page(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Scroll_Article_horizon() {
    return Scrollbar(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.18,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            //article main open widget
            Article_Page_scroll(),
            SizedBox(width: 12),
            //widget open link covid 19
            Article_Page_scroll2(),
          ],
        ),
      ),
    );
  }

  Widget Games_Page() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width * 0.39,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(255, 88, 59, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/images/logo/game.png"),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: Text(
                    "เกมทดสอบสมรรถภาพ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            onPressed: () {
              //save data history
              history = "G";
              print("games page click");
              User_history();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_game()));
              User_history();
            }));
  }

  Widget Article_Page() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width * 0.39,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(13, 59, 102, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/images/logo/article.png"),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: Text(
                    "เกี่ยวกับใบขับขี่   ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            onPressed: () {
              //save data history
              history = "R";
              User_history();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_article()));
            }));
  }

  Widget Charage_Page() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width * 0.39,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(76, 228, 177, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 40,
                  child: Image(
                    image: AssetImage("assets/images/logo/charange.png"),
                  ),
                ),
                Spacer(),
                Container(
                  child: Text(
                    "แบบทดสอบ        ",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
            onPressed: () {
              //save data history
              history = "T";
              User_history();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Guide_charange()));
            }));
  }

  Widget Article_Page_scroll() {
    return GestureDetector(
      onTap: () {
        //save history
        history = "R";
        User_data();
        cateService();
        print("click");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home_article()));
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/scrolls/articlescroll.jpg"),
                  fit: BoxFit.cover)),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: Image(
                        image: AssetImage("assets/images/logo/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      child: Text(
                        "easy drive",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  "บทความการขับขี่",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> User_history() async {
    String url =
        '${Domain_name().domain}/easy_drive_backend/user/mobile/last_menu.php?user_id=$displayID';
    var dataReq = {};
    dataReq["last_menu"] = history;
    String data = jsonEncode(dataReq);
    var response = await Dio().put(url, data: data);
    try {
      print("response = ${response.toString()}");
      if (response.toString() == "error") {
        print("ERROR don't call api");
      } else if (response.toString() == "complate") {
        print("last menu is : ${history}");
      }
    } catch (e) {
      print("ERROR");
    }
  }

  Widget Article_Page_scroll2() {
    return GestureDetector(
      onTap: () {
        //save history
        history = "R";
        User_data();
        User_history();
        setState(() {
          _url = 'https://www.dlt.go.th/th/public-news/view.php?_did=2858';
        });
        print("games page click");
        check_link();
      },
      child: Card(
        shadowColor: Colors.black,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/scrolls/scroll2.jpg"),
                  fit: BoxFit.cover)),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget Timer_count() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amber.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("ทดสอบนับถอยหลัง"),
            onPressed: () {
              print("timer countdown click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Timer_count()));
            }));
  }

  Widget Show_username() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        // "${displayName},${displayID}",
        "${displayName}",
        style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget article_charange() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
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
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage(
                            "assets/images/logo/article_charange.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text("แนวข้อสอบ"),
                  ),
                ],
              ),
            ),
            onPressed: () {
              //save history
              history = "P";
              User_history();
              print("games colors click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => home_sample()));
            }));
  }

  Widget history_charange() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
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
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(252, 183, 7, 1),
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/logo/history.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text("ประวัติการทำแบบทดสอบ"),
                  ),
                ],
              ),
            ),
            onPressed: () {
              //save history
              history = "H";
              User_history();
              print("games colors click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => History_charage()));
            }));
  }

  Widget test() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
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
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(252, 183, 7, 1),
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage("assets/images/logo/history.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text("test"),
                  ),
                ],
              ),
            ),
            onPressed: () {
              //save history
              history = "H";
              User_history();
              print("games colors click");
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Sample()));
            }));
  }

  //thead save data open main article
  Future<Null> cateService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('CATERGORY_ID', id_cate);
    preferences.setString('CATERGORY_NAME', name_cate);
  }

  //function check link
  check_link() {
    if (_url != '') {
      _launchURL();
    } else {
      print("Url id empty");
    }
  }

  //open link with URL luancher
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw "could not launch $_url";
}
