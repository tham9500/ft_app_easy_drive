import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/login.dart';
import 'package:ft_app_easy_drive/pages/registor.dart';
import 'package:ft_app_easy_drive/widget/custom_shape.dart';
import '../pages/test_page/time_countdown.dart';

class Home_page extends StatefulWidget {
  Home_page({Key? key}) : super(key: key);

  @override
  _Home_pageState createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(220.0),
        child: AppBar(
          centerTitle: true,
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
                                    "ยินดีต้อนรับ",
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
                              children: <Widget>[
                                Btn_Login(),
                                SizedBox(width: 25),
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
              Scroll_Article_horizon(),
              SizedBox(
                height: 20,
              ),
              Scroll_menu()
            ],
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
                  Article_Page(),
                  SizedBox(width: 20),
                  Games_Page()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Scroll_Article_horizon() {
    return Container(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Article_Page_scroll(),
          SizedBox(width: 12),
          Article_Page_scroll2(),
        ],
      ),
    );
  }

  Widget Games_Page() {
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
            child: Text("เกมส์ทดสอบสมรรถภาพการขับรถ"),
            onPressed: () {
              print("games colors click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_game()));
            }));
  }

  Widget Article_Page() {
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
            child: Text("บทความเกี่ยวกับใบขับขี่"),
            onPressed: () {}));
  }

  Widget Article_Page_scroll() {
    return Card(
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
          ],
        ),
      ),
    );
  }

  Widget Article_Page_scroll2() {
    return Card(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Container(
                    child: MaterialButton(
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Timer_count() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width,

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
            child: Text("ทดสอบนับถอยหลัง"),
            onPressed: () {
              print("timer countdown click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Time_countdown()));
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
                ))),
            child: Text(
              "ลงทะเบียน",
              style: TextStyle(fontSize: 16, color: Colors.orange.shade800),
            ),
            onPressed: () {
              print("registor click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Registor_page()));
            }));
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
                ))),
            child: Text(
              "เข้าสู่ระบบ",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              print("login click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Login_page()));
            }));
  }
}
