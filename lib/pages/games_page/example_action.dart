import 'dart:math';

import 'package:flutter/material.dart';

class Example_action extends StatefulWidget {
  Example_action({Key? key}) : super(key: key);

  @override
  _Example_actionState createState() => _Example_actionState();
}

class _Example_actionState extends State<Example_action> {
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  Color _color = Colors.black;
  Color _color2 = Colors.grey;
  int showarea = 0;
  int showcolor = 0;

  void initState() {
    super.initState();
    show_area();
  }

  show_area() {
    final random_area = Random().nextInt(3);
    if (random_area == 0) {
      print("container 1");
      showarea = 1;
      show_color();
    } else if (random_area == 1) {
      print("container 2");
      showarea = 2;
      show_color();
    } else if (random_area == 2) {
      print("container 3");
      showarea = 3;
      show_color();
    }
  }

  show_color() {
    final random_color = Random().nextInt(3);
    if (random_color == 0) {
      showcolor = 1;
      print("red");
    } else if (random_color == 1) {
      showcolor = 2;
      print("yellow");
    } else if (random_color == 2) {
      showcolor = 3;
      print("green");
    }
  }

  // Color() {
  //   if (showcolor == 0) {
  //     return Colors.grey;
  //   } else if (showcolor == 1) {
  //     return Colors.red;
  //   } else if (showcolor == 2) {
  //     return Colors.yellow;
  //   } else if (showcolor == 3) {
  //     return Colors.green;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    void show_color() {}

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("เกมส์ทดสอบสายตาทางลึก"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Container(
                    height: 400,
                    width: 150,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: _borderRadius,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Center(
                  child: Container(
                    height: 30,
                    width: 300,
                    decoration: BoxDecoration(
                      color: _color2,
                      borderRadius: _borderRadius,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Center(
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: _borderRadius,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Btn_1(),
                        SizedBox(width: 25),
                        Btn_2(),
                        SizedBox(width: 25),
                        Btn_3(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Btn_1() {
    return Container(

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("Red"),
            onPressed: () {
              show_area();
            }));
  }

  Widget Btn_2() {
    return Container(

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("Yellow"),
            onPressed: () {
              show_area();
            }));
  }

  Widget Btn_3() {
    return Container(

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("Green"),
            onPressed: () {
              show_area();
            }));
  }
}
