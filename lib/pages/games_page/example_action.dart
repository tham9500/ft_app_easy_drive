import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/end_game/end_action/fail_action.dart';
import 'package:ft_app_easy_drive/pages/games_page/end_game/end_action/pass_action.dart';
import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';

class Example_action extends StatefulWidget {
  Example_action({Key? key}) : super(key: key);

  @override
  _Example_actionState createState() => _Example_actionState();
}

class _Example_actionState extends State<Example_action> {
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  Color _color = Colors.black;
  Color _color2 = Colors.grey;
  int Num_quiz = 0;
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
    finish_test();
    // check_answer();
    // show_color();
  }

  show_area() {
    final random_area = Random().nextInt(3);
    if (random_area == 0) {
      // print("container 1");
      showarea = 0;
      show_color1();
    } else if (random_area == 1) {
      // print("container 2");
      showarea = 1;
      show_color2();
    } else if (random_area == 2) {
      // print("container 3");
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
      // print("red 1");
      // print("condition = ${question}");
      return Container(color: Colors.red);
    } else if (random_color == 1) {
      question = 2;
      showcolor1 = 2;

      // print("yellow 2");
      // print("condition = ${question}");
      return Container(color: Colors.yellow);
    } else if (random_color == 2) {
      question = 3;
      showcolor1 = 3;

      // print("green 3");
      // print("condition = ${question}");
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
      // print("condition = ${question}");
      return Container(color: Colors.red);
    } else if (random_color == 1) {
      question = 2;
      showcolor2 = 2;

      // print("yellow");
      // print("condition = ${question}");
      return Container(color: Colors.yellow);
    } else if (random_color == 2) {
      question = 3;
      showcolor2 = 3;
      question = 3;
      // print("green");
      // print("condition = ${question}");
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
      // print("condition = ${question}");
      return Container(color: Colors.red);
    } else if (random_color == 1) {
      showcolor3 = 2;
      question = 2;
      // print("yellow");
      // print("condition = ${question}");
      return Container(color: Colors.yellow);
    } else if (random_color == 2) {
      showcolor3 = 3;
      question = 3;
      // print("green");
      // print("condition = ${question}");
      return Container(color: Colors.green);
    } else {}
    print("condition = ${question}");
  }

  reset() {
    answer = 0;
    question = 0;
    // print("answer = ${answer}");
    // print("question = ${question}");
  }

  int Counter = 3;
  int maxCount = 3;
  late Timer _timer;

  void startTimer() {
    Counter = 3;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (Counter > -1) {
        Counter--;

        setState(() {
          if (Counter < 0) {
            Num_quiz++;
            finish_test();
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

  finish_test() {
    print("Number = ${Num_quiz}");
    if (Num_quiz == 5) {
      if (score < 3) {
        _timer.cancel();
        print("FAIL");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Fail_action()));
      } else if (score >= 3) {
        _timer.cancel();
        print("SUCCESS");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Pass_action()));
      }
    } else {
      print("continue");
    }
  }

  @override
  Widget build(BuildContext context) {
    void show_color() {}

    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                child: Row(
                  children: <Widget>[
                    Btn_exit(),
                   
                  ],
                ),
              ),
              Container(
                child: Center(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "คะเเนน ${score}/5",
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
                                SizedBox(height: 20),
                                light_2(),
                                SizedBox(height: 20),
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
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 7.5,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    LinearProgressIndicator(
                      value: Counter / maxCount,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage(
                            "assets/images/game_icon/notification4.png"),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      child: Text(
                        ": ${Counter} วินาที",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(8),
                alignment: Alignment.centerLeft,
                child: Text(
                  "ครั้งที่ : ${Num_quiz}/5",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),
              Container(
                child: Center(
                  child: Container(
                    height: 50,
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
              Num_quiz++;
              setState(() {
                // show_area();
                answer = 1;
                if (question == answer) {
                  score++;
                  // print("true");
                  reset();
                  show_area();
                } else {
                  // print("false");
                  reset();
                  show_area();
                }
                // check_answer();
                // show_color();
                finish_test();
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
              Num_quiz++;
              setState(() {
                // show_area();
                answer = 2;
                if (question == answer) {
                  score++;
                  // print("true");
                  reset();
                  show_area();
                } else {
                  // print("false");
                  reset();
                  show_area();
                }
                // check_answer();
                // show_color();
                finish_test();
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
              Num_quiz++;
              setState(() {
                // show_area();
                answer = 3;
                if (question == answer) {
                  score++;
                  // print("true");
                  reset();
                  show_area();
                } else {
                  // print("false");
                  reset();
                  show_area();
                }
                // check_answer();
                // show_color();
                finish_test();
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

  Widget Btn_exit() {
    return Container(
      child: IconButton(
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Home_game()));
          _showMyDialogPass("ออก");
        },
        icon: Icon(Icons.exit_to_app),
      ),
    );
  }

  Future<void> _showMyDialogPass(content) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       Container(
          //           // child: Center(
          //           //   child: Text("$content"),
          //           // ),
          //           ),
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Image(
                        image: AssetImage("assets/images/game_icon/exit.png")),
                  ),
                  SizedBox(width: 20),
                  Container(
                    child: Text(
                      "หากกดออกหรือปอดแอพพลิเคชัน\nระหว่างการทดสอบ การทดสอบ\nจะสิ้นสุดลง",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: TextButton(
                      child: const Text(
                        'DISAGREE',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      child: const Text(
                        'AGREE',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home_game()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
