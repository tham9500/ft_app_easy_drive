import 'dart:async';

import 'package:flutter/material.dart';

class Time_countdown extends StatefulWidget {
  Time_countdown({Key? key}) : super(key: key);

  @override
  _Time_countdownState createState() => _Time_countdownState();
}

class _Time_countdownState extends State<Time_countdown> {
  int Counter = 20;
  late Timer _timer;

  void startTimer() {
    Counter = 20;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (Counter > 0) {
        setState(() {
          Counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$Counter',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                onPressed: () {
                  startTimer();
                },
                child: Text('Start timer')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _timer.cancel();
                    Counter = 20;
                  });
                },
                child: Text('Pause')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _timer.cancel();
                    Counter = 20;
                  });
                },
                child: Text('Reset')),
          ],
        ),
      ),
    );
  }
}
