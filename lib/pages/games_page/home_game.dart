import 'package:ft_app_easy_drive/pages/games_page/example_distance.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/example_eyecolor.dart';

class Home_game extends StatefulWidget {
  Home_game({Key? key}) : super(key: key);

  @override
  _Home_gameState createState() => _Home_gameState();
}

class _Home_gameState extends State<Home_game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("เกมส์ทดสอบสมมรรถภาพการขับรถ"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              Games_distance(),
              SizedBox(height: 20),
              Game_Colors(),
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
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width,
        // color: Colors.amber.shade200,
        child: RaisedButton(
            color: Colors.amber.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text("เกมส์ทดสอบสายตายทางลึก"),
            onPressed: () {
              print("games click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Example_distance()));
            }));
  }

  Widget Game_Colors() {
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
            child: Text("เกมส์ทดสอบตาบอดสี"),
            onPressed: () {
              print("games colors click");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => example_eyecolo()));
            }));
  }

  Widget Game_Action() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: RaisedButton(
            color: Colors.amber.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text("เกมส์ทกสอบปฏิกริยา"),
            onPressed: () {
              print("games click");
            }));
  }
}
