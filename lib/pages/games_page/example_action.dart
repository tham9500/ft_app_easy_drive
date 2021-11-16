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

  // var area1 = false;
  // var area2 = false;
  // var area3 = false;

  // var red = false;
  // var yellow = false;
  // var green = false;
  // var grey = true;
  List colorList = [Colors.grey, Colors.red, Colors.yellow, Colors.green];

  void initState() {
    super.initState();
    show_area();
    show_color();
  }

  show_area() {
    final random_area = Random().nextInt(3);
    if (random_area == 0) {
      print("container 1");
      showarea = 0;
      show_color();
    } else if (random_area == 1) {
      print("container 2");
      showarea = 1;
      show_color();
    } else if (random_area == 2) {
      print("container 3");
      showarea = 2;
      show_color();
    }
  }

  show_color() {
    final random_color = Random().nextInt(3);
    if (random_color == 0) {
      showcolor = 1;
      print("color = ${showcolor}");
      return Container(color: Colors.red);
    } else if (random_color == 1) {
      showcolor = 2;
      print("color = ${showcolor}");
      print("yellow");
      return Container(color: Colors.yellow);
    } else if (random_color == 2) {
      showcolor = 3;
      print("color = ${showcolor}");
      print("green");
      return Container(color: Colors.green);
    } else {}
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: [
                                light_1(),
                              ],
                            ),
                          ),
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
                      Container(
                        child: Center(),
                      ),
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
              print(colorList[showcolor]);
              show_area();
              // show_color();
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
              print(colorList[showcolor]);
              show_area();
              // show_color();
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
              print(colorList[showcolor]);
              setState(() {
                show_area();
                // show_color();
              });
            }));
  }

  Widget light_1() {
    return Container(
      child: AnimatedContainer(
        // Use the properties stored in the State class.
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: colorList[showcolor],
          shape: BoxShape.circle,
        ),
        // Define how long the animation should take.
        duration: const Duration(seconds: 0),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
}
