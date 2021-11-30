import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/screen_example/screen_main.dart';

class Load_example extends StatefulWidget {
  Load_example({Key? key}) : super(key: key);

  @override
  _Load_exampleState createState() => _Load_exampleState();
}

class _Load_exampleState extends State<Load_example> {
  int Counter = 3;
  late Timer _timer;
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Counter = 3;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (Counter > 0) {
        setState(() {
          Counter--;
          if (Counter == 0) {
            print("time out");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Screen_main()));
          }
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void time_out() {
    if (Counter == 0) {
      print("time out");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Screen_main()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$Counter',
              style: TextStyle(fontSize: 75, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
