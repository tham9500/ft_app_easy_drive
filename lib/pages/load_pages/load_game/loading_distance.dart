import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/example_distance.dart';

class Loading_distance extends StatefulWidget {
  Loading_distance({Key? key}) : super(key: key);

  @override
  _Loading_distanceState createState() => _Loading_distanceState();
}

class _Loading_distanceState extends State<Loading_distance> {
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
                MaterialPageRoute(builder: (context) => Example_distance()));
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
          context, MaterialPageRoute(builder: (context) => Example_distance()));
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
