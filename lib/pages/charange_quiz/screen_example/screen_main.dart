import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/controller/test_charange/test_chrrange.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/guide_charange.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';

class Screen_main extends StatefulWidget {
  Screen_main({Key? key}) : super(key: key);

  @override
  _Screen_mainState createState() => _Screen_mainState();
}

class _Screen_mainState extends State<Screen_main> {
  Charange data = Charange();
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 0;
  final int timerMaxMinute = 1;

  int currentSeconds = 0;
  int currentMinute = 0;
  List<dynamic> Quiz = [];
  String get timerText =>
      '${((timerMaxMinute - currentMinute) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int milliseconds = 0]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        //print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  void initState() {
    startTimeout();
    super.initState();
    Quiz_charage();
  }

  Quiz_charage() {
    print("data_list = ${data.charange.length}");
    for (int i = 0; i < data.charange.length; i++) {
      Quiz.add(data.charange[i]);
    }
    print("Quiz list total = ${Quiz.length}");
    print("Quiz data total = ${Quiz}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Btn_exit(),
          actions: <Widget>[Timer_count()],

          flexibleSpace: ClipRRect(
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(50),
            //     bottomRight: Radius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
                                // Container(
                                //   child: Text(
                                //     "เครื่องหมายนจราจร",
                                //     style: TextStyle(
                                //         fontSize: 28,
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.white),
                                //     textAlign: TextAlign.left,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
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
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(50),
              //     bottomRight: Radius.circular(50)),
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 700,
                child: PageView.builder(
                  itemCount: Quiz.length,
                  itemBuilder: (context, index) {
                    print(Quiz[index]["ID"]);
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Qeustion_show(index),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Btn_exit() {
    return Container(
      child: IconButton(
        color: Colors.red,
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Home_game()));
          _showMyDialogPass("ออก");
        },
        icon: Icon(
          Icons.exit_to_app,
          size: 35,
        ),
      ),
    );
  }

  Widget Qeustion_show(index) {
    print("img quiz = ${Quiz[index]["image"]}");
    return Container(
      child: Quiz[index]["image"] == ""
          ? Qeustion_NoImage(index)
          : Qeustion_HaveImage(index),
    );
  }

  Widget Qeustion_NoImage(index) {
    print("NO");
    return Container(
      child: Text(
        "No image",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget Qeustion_HaveImage(index) {
    print("YES");
    return Container(
      child: Text(
        "Have image",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Widget Timer_count() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.access_alarm,
              color: Colors.red,
              size: 30,
            ),
          ),
          SizedBox(width: 15),
          Container(
            child: Text(
              "${timerText} ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            alignment: Alignment.centerRight,
          ),
        ],
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
                                builder: (context) => Guide_charange()));
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
