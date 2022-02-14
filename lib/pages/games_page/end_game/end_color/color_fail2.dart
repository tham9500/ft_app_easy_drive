import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/guide_games/guide_color.dart';
import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';

class Color_fail2 extends StatefulWidget {
  Color_fail2({Key? key}) : super(key: key);

  @override
  _Color_fail2State createState() => _Color_fail2State();
}

class _Color_fail2State extends State<Color_fail2> {
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
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 128,
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
                  "คุณตาบอดสี",
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
