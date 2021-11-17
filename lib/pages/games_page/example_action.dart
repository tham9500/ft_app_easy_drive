import 'dart:async';
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
  int showcolor1 = 0;
  int showcolor2 = 0;
  int showcolor3 = 0;
  int question = 0;
  int answer = 0;
  int score = 0;

  // var area1 = false;
  // var area2 = false;
  // var area3 = false;

  // var red = false;
  // var yellow = false;
  // var green = false;
  // var grey = true;
  List colorList_light1 = [
    Colors.grey,
    Colors.red,
    Colors.yellow,
    Colors.green
  ];
  List colorList_light2 = [
    Colors.grey,
    Colors.red,
    Colors.yellow,
    Colors.green
  ];
  List colorList_light3 = [
    Colors.grey,
    Colors.red,
    Colors.yellow,
    Colors.green
  ];

  void initState() {
    super.initState();
    show_area();
    startTimer();
    // check_answer();
    // show_color();
  }

  show_area() {
    final random_area = Random().nextInt(3);
    if (random_area == 0) {
      print("container 1");
      showarea = 0;
      show_color1();
    } else if (random_area == 1) {
      print("container 2");
      showarea = 1;
      show_color2();
    } else if (random_area == 2) {
      print("container 3");
      showarea = 2;
      show_color3();
    }
  }

  show_color1() {
    final random_color = Random().nextInt(3);
    showcolor2 = 0;
    showcolor3 = 0;
    if (random_color == 0) {
      question = 1;

      showcolor1 = 1;
      print("red 1");
      print("condition = ${question}");
      return Container(color: Colors.red);
    } else if (random_color == 1) {
      question = 2;
      showcolor1 = 2;

      print("yellow 2");
      print("condition = ${question}");
      return Container(color: Colors.yellow);
    } else if (random_color == 2) {
      question = 3;
      showcolor1 = 3;

      print("green 3");
      print("condition = ${question}");
      return Container(color: Colors.green);
    } else {}
    print("condition = ${question}");
  }

  show_color2() {
    final random_color = Random().nextInt(3);
    showcolor1 = 0;
    showcolor3 = 0;
    if (random_color == 0) {
      question = 1;
      showcolor2 = 1;
      print("condition = ${question}");
      return Container(color: Colors.red);
    } else if (random_color == 1) {
      question = 2;
      showcolor2 = 2;

      print("yellow");
      print("condition = ${question}");
      return Container(color: Colors.yellow);
    } else if (random_color == 2) {
      question = 3;
      showcolor2 = 3;
      question = 3;
      print("green");
      print("condition = ${question}");
      return Container(color: Colors.green);
    } else {}
    print("condition = ${question}");
  }

  show_color3() {
    final random_color = Random().nextInt(3);
    showcolor1 = 0;
    showcolor2 = 0;
    if (random_color == 0) {
      showcolor3 = 1;
      question = 1;
      print("condition = ${question}");
      return Container(color: Colors.red);
    } else if (random_color == 1) {
      showcolor3 = 2;
      question = 2;
      print("yellow");
      print("condition = ${question}");
      return Container(color: Colors.yellow);
    } else if (random_color == 2) {
      showcolor3 = 3;
      question = 3;
      print("green");
      print("condition = ${question}");
      return Container(color: Colors.green);
    } else {}
    print("condition = ${question}");
  }

  reset() {
    answer = 0;
    question = 0;
    print("answer = ${answer}");
    print("question = ${question}");
  }

  int Counter = 3;
  late Timer _timer;

  void startTimer() {
    Counter = 3;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (Counter > -1) {
        Counter--;
        setState(() {
          if (Counter < 0) {
            reset();
            show_area();
            Counter = 3;
          }
        });
      } else {
        _timer.cancel();
      }
    });
  }

  // void time_out() {
  //   if (Counter == 0) {
  //     reset();
  //     show_area();
  //     startTimer();
  //   }
  // }

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
                    alignment: Alignment.centerRight,
                    child: Text(
                      "${score}/5",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
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
                                SizedBox(height: 25),
                                light_2(),
                                SizedBox(height: 25),
                                light_3(),
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
                    child: Text("${Counter}"),
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
              Counter = 3;
              setState(() {
                // show_area();
                answer = 1;
                if (question == answer) {
                  score++;
                  print("true");
                  reset();
                  show_area();
                } else {
                  print("false");
                  reset();
                  show_area();
                }
                // check_answer();
                // show_color();
              });
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
              Counter = 3;
              setState(() {
                // show_area();
                answer = 2;
                if (question == answer) {
                  score++;
                  print("true");
                  reset();
                  show_area();
                } else {
                  print("false");
                  reset();
                  show_area();
                }
                // check_answer();
                // show_color();
              });
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
              Counter = 3;
              setState(() {
                // show_area();
                answer = 3;
                if (question == answer) {
                  score++;
                  print("true");
                  reset();
                  show_area();
                } else {
                  print("false");
                  reset();
                  show_area();
                }
                // check_answer();
                // show_color();
              });
            }));
  }

  Widget light_1() {
    return Container(
      child: AnimatedContainer(
        // Use the properties stored in the State class.
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: colorList_light2[showcolor1],
          shape: BoxShape.circle,
        ),
        // Define how long the animation should take.
        duration: const Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  Widget light_2() {
    return Container(
      child: AnimatedContainer(
        // Use the properties stored in the State class.
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: colorList_light3[showcolor2],
          shape: BoxShape.circle,
        ),
        // Define how long the animation should take.
        duration: const Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  Widget light_3() {
    return Container(
      child: AnimatedContainer(
        // Use the properties stored in the State class.
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          color: colorList_light3[showcolor3],
          shape: BoxShape.circle,
        ),
        // Define how long the animation should take.
        duration: const Duration(seconds: 1),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.easeInOutCirc,
      ),
    );
  }
}
