import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';
import 'package:ft_app_easy_drive/pages/load_pages/load_game/loading_distance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Guide_distance extends StatefulWidget {
  Guide_distance({Key? key}) : super(key: key);

  @override
  _Guide_distanceState createState() => _Guide_distanceState();
}

class _Guide_distanceState extends State<Guide_distance> {
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
    } else {
      print("Not login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_game()));
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
                    color: Color.fromRGBO(230, 238, 246, 1),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/game_icon/length.png"),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  child: Center(
                    child: Text(
                      "ทดสอบสายตาทางลึก",
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(13, 59, 102, 1)),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Btn_Start(),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ข้อกำหนดก่อนเริ่มทำแบบทดสอบ",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          //color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage(
                                "assets/images/game_icon/notification1.png"),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "ใช้ลูกศรเลื่อนแท่ง A สีเขียวให้ตรง\nกับแท่ง B สีแดงให้ได้มากที่สุด",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 500,
                  width: 460,
                  child: Image.asset("assets/images/game_icon/title.png"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Btn_Start() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange.shade800),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ))),
            child: Text(
              "เริ่ม",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              print("Submit click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Loading_distance()));
            }));
  }
}
