import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/load_example/load_example.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';

class Guide_charange extends StatefulWidget {
  Guide_charange({Key? key}) : super(key: key);

  @override
  _Guide_charangeState createState() => _Guide_charangeState();
}

class _Guide_charangeState extends State<Guide_charange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_login()));
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
                      image: AssetImage("assets/images/logo/charange.png"),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  child: Center(
                    child: Text(
                      "แบบทดสอบ",
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(13, 59, 102, 1)),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Btn_History(),
                        SizedBox(width: 20),
                        Btn_Start(),
                      ],
                    ),
                  ),
                ),
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
                                "assets/images/game_icon/notification4.png"),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "การทดสอบโดยมีการจับเวลา\n60 นาที",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
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
                                "assets/images/game_icon/notification5.png"),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "การทดสอบจะเป็นการสุ่มเลือก\nทั้งหมด 50 ข้อ",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
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
                                "assets/images/game_icon/notification6.png"),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "การทดสอบเป็นการจำลองเท่านั้น\nและไม่มีผลต่อการสอบจริง",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
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
                            image:
                                AssetImage("assets/images/game_icon/exit.png"),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "หากกดออกหรือปิดแอพพลิเคชัน\nระหว่างสอบ การสอบจะสิ้นสุดลง",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget test() {
    return Container();
  }

  Widget Btn_Start() {
    return Container(
        height: 50,
        width: 150,

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
                  MaterialPageRoute(builder: (context) => Load_example()));
            }));
  }

  Widget Btn_History() {
    return Container(
        height: 50,
        width: 150,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ))),
            child: Text(
              "ประวัติ",
              style: TextStyle(fontSize: 16, color: Colors.orange.shade700),
            ),
            onPressed: () {
              print("Submit click");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Loading_color()));
            }));
  }
}
