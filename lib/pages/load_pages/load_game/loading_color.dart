import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/example_eyecolor.dart';

class Loading_color extends StatefulWidget {
  Loading_color({Key? key}) : super(key: key);

  @override
  _Loading_colorState createState() => _Loading_colorState();
}

class _Loading_colorState extends State<Loading_color> {
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
                MaterialPageRoute(builder: (context) => example_eyecolo()));
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
          context, MaterialPageRoute(builder: (context) => example_eyecolo()));
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