import 'package:ft_app_easy_drive/pages/games_page/example_distance.dart';
import 'package:flutter/material.dart';

class Hoem_game extends StatefulWidget {
  Hoem_game({Key? key}) : super(key: key);

  @override
  _Hoem_gameState createState() => _Hoem_gameState();
}

class _Hoem_gameState extends State<Hoem_game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
        child: RaisedButton(
            color: Colors.amber.shade300,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text("เกมส์ทกสอบตาบอดสี"),
            onPressed: () {
              print("games click");
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
