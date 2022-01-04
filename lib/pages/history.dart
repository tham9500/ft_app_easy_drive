import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_login.dart';

class History_charage extends StatefulWidget {
  History_charage({Key? key}) : super(key: key);

  @override
  _History_charageState createState() => _History_charageState();
}

class _History_charageState extends State<History_charage> {
  String displayID = "";
  String status = "";
  bool btn_s1 = true;
  bool btn_s2 = false;
  bool btn_s3 = false;

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
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "ประวัติการทำแบบทดสอบ",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
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
            padding: const EdgeInsets.all(8),
            child: Center(
              child: Column(
                children: <Widget>[
                  Btn_day(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Btn_day() {
    return Container(
      // padding: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      alignment: Alignment.center,
      // height: 50,
      // width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(
      //   color: Colors.amber.shade200,
      //   borderRadius: BorderRadius.circular(60),
      // ),
      child: Center(
        child: Row(
          children: <Widget>[
            SizedBox(width: 6),
            Container(
              width: 110,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: btn_s1 == true
                      ? MaterialStateProperty.all<Color>(
                          Colors.orangeAccent.shade400)
                      : MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Text("วัน", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  setState(() {
                    btn_s1 = true;
                    btn_s2 = false;
                    btn_s3 = false;
                  });
                  print("state 1");
                },
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 110,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: btn_s2 == true
                      ? MaterialStateProperty.all<Color>(
                          Colors.orangeAccent.shade400)
                      : MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Text(
                  "สัปดาห์",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    btn_s1 = false;
                    btn_s2 = true;
                    btn_s3 = false;
                  });
                  print("state 2");
                },
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 110,
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: btn_s3 == true
                      ? MaterialStateProperty.all<Color>(
                          Colors.orangeAccent.shade400)
                      : MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                child: Text("เดือน", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  setState(() {
                    btn_s1 = false;
                    btn_s2 = false;
                    btn_s3 = true;
                  });
                  print("state 3");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
