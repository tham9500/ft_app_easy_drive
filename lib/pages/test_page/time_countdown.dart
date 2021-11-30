import 'dart:async';

import 'package:flutter/material.dart';

class Time_countdown extends StatefulWidget {
  Time_countdown({Key? key}) : super(key: key);

  @override
  _Time_countdownState createState() => _Time_countdownState();
}

class _Time_countdownState extends State<Time_countdown> {
  int Counter = 20;
  int maxCount = 20;
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 35,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LinearProgressIndicator(
                    value: Counter / maxCount,
                  ),
                ],
              ),
            ),
            Text(
              '$Counter',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                onPressed: () {
                  print('start counter');
                  startTimer();
                },
                child: Text('Start timer')),
            ElevatedButton(
                onPressed: () {
                  print('pause');
                  setState(() {
                    _timer.cancel();
                    Counter = 20;
                  });
                },
                child: Text('Pause')),
            ElevatedButton(
                onPressed: () {
                  print('reset');
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

  Widget buildTimer() {
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
      ),
    );
  }
}
