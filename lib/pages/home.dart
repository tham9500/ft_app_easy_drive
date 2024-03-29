import 'package:ft_app_easy_drive/pages/article/home_article.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article.dart';
import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/login.dart';
import 'package:ft_app_easy_drive/pages/registor.dart';
import 'package:ft_app_easy_drive/pages/verify_email.dart';
import 'package:ft_app_easy_drive/widget/custom_shape.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/test_page/time_countdown.dart';

class Home_page extends StatefulWidget {
  Home_page({Key? key}) : super(key: key);

  @override
  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  //url open link covid 19 home
  String _url = '';
  //data open article main
  String id_cate = "1641395148";
  String name_cate = "รอบรู้เรื่องขับขี่";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.19),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false, //move back button
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => Home_game()));
          //   },
          //   icon: Icon(Icons.arrow_back_ios),
          // ),
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
              padding: const EdgeInsets.all(20.0),
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
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "ยินดีต้อนรับ",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Prompt"),
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
                              children: <Widget>[
                                //widget buttom login
                                Btn_Login(),
                                SizedBox(width: 25),
                                //widget buttom register
                                Btn_registor()
                              ],
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
                //menu scroll horizantal
                Scroll_Article_horizon(), //widget scroll horizantal
                SizedBox(height: 20),
                //main menu
                Scroll_menu()
              ],
            ),
          ),
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
                  //widget open page game
                  Games_Page(),
                  SizedBox(width: 20),
                  //widget open page catergory
                  Article_Page(),
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
            //open article main widget
            Article_Page_scroll(),
            SizedBox(width: 12),
            //open web article sample
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
              print("games colors click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_game()));
            }));
  }

  Widget Article_Page() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.14,
        width: MediaQuery.of(context).size.width * 0.39,

        // color: Colors.amber.shade200,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_article()));
            }));
  }

  Widget Article_Page_scroll() {
    return GestureDetector(
      onTap: () {
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
                      height: 40,
                      width: 40,
                      child: Image(
                        image: AssetImage("assets/images/logo/logo.png"),
                      ),
                    ),
                    Container(
                      child: Text(
                        "easy drive",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
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

  Widget Article_Page_scroll2() {
    return GestureDetector(
      onTap: () {
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
        height: 120,
        width: 150,
        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amber.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("ทดสอบนับถอยหลัง\nทดสอบ WIDGET"),
            onPressed: () {
              print("timer countdown click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Time_countdown()));
            }));
  }

  Widget verify_test() {
    return Container(
        height: 120,
        width: 150,
        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.amber.shade300),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("ทดสอบ verrfy"),
            onPressed: () {
              print("timer countdown click");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Verify_email()));
            }));
  }

  Widget Btn_registor() {
    return Container(
      height: 40,
      width: 130,

      // color: Colors.amber.shade200,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: Text(
          "ลงทะเบียน",
          style: TextStyle(fontSize: 16, color: Colors.orange.shade800),
        ),
        onPressed: () {
          print("registor click");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Registor_page()));
        },
      ),
    );
  }

  Widget Btn_Login() {
    return Container(
      height: 40,
      width: 130,

      // color: Colors.amber.shade200,
      child: ElevatedButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.orange.shade800),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        child: Text(
          "เข้าสู่ระบบ",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () {
          print("login click");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login_page()));
        },
      ),
    );
  }

  //thead save date to open page article
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

  //open link with URL launcher
  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw "could not launch $_url";
}
