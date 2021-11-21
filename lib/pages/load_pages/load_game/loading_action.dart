import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/games_page/example_action.dart';

class Loading_action extends StatefulWidget {
  Loading_action({Key? key}) : super(key: key);

  @override
  _Loading_actionState createState() => _Loading_actionState();
}

class _Loading_actionState extends State<Loading_action> {
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
                MaterialPageRoute(builder: (context) => Example_action()));
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
          context, MaterialPageRoute(builder: (context) => Example_action()));
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
