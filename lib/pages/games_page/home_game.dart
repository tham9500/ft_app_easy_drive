import 'package:ft_app_easy_drive/pages/games_page/example_action.dart';
import 'package:ft_app_easy_drive/pages/games_page/example_distance.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/example_eyecolor.dart';
import 'package:ft_app_easy_drive/pages/games_page/guide_games/guide_color.dart';
import 'package:ft_app_easy_drive/pages/games_page/guide_games/guide_distancec.dart';

class Home_game extends StatefulWidget {
  Home_game({Key? key}) : super(key: key);

  @override
  _Home_gameState createState() => _Home_gameState();
}

class _Home_gameState extends State<Home_game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
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
                  color: Color.fromRGBO(230, 238, 246, 1),
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage("assets/images/game_icon/main_game.png"),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                child: Center(
                  child: Text(
                    "เกมทดสอบสมรรถภาพ",
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(13, 59, 102, 1)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Game_Colors(),
              SizedBox(height: 20),
              Games_distance(),
              SizedBox(height: 20),
              Game_Action(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Games_distance() {
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
                        image: AssetImage("assets/images/game_icon/length.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text("ทดสอบสายตาทางลึก"),
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
                  MaterialPageRoute(builder: (context) => Guide_distance()));
            }));
  }

  Widget Game_Colors() {
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
                        image: AssetImage("assets/images/game_icon/color.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text("ทดสอบการมองเห็นสี\nสำหรับการขับรถ"),
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
                  MaterialPageRoute(builder: (context) => Guide_color()));
            }));
  }

  Widget Game_Action() {
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
                        image: AssetImage("assets/images/game_icon/action.png"),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    width: 210,
                    child: Text("ทดสอบการมองเห็นสี\nสำหรับการขับรถ"),
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
              print("games action click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Example_action()));
            }));
  }
}
