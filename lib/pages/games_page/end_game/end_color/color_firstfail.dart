import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/guide_games/guide_color.dart';
import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';

class Fail_Color extends StatefulWidget {
  Fail_Color({Key? key}) : super(key: key);

  @override
  _Fail_ColorState createState() => _Fail_ColorState();
}

class _Fail_ColorState extends State<Fail_Color> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                      image: AssetImage("assets/animation/fail-animation.gif"),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Text(
                  "ไม่ผ่าน",
                  style: TextStyle(fontSize: 48, color: Colors.red),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Text(
                  "คุณตาบอดสีแดงและเขียว",
                  style: TextStyle(fontSize: 28, color: Colors.red),
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Btn_again(),
                    SizedBox(width: 30),
                    Btn_back(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Btn_again() {
    return Container(
        height: 50,
        width: 150,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            child: Text(
              "เริ่มใหม่",
              style:
                  TextStyle(fontSize: 16, color: Color.fromRGBO(255, 0, 0, 1)),
            ),
            onPressed: () {
              print("registor click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Guide_color()));
            }));
  }

  Widget Btn_back() {
    return Container(
        height: 50,
        width: 150,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(255, 0, 0, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ))),
            child: Text(
              "กลับสู่หน้าจอหลัก",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              print("login click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_game()));
            }));
  }
}
