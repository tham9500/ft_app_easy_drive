import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';

class Example_distance extends StatefulWidget {
  Example_distance({Key? key}) : super(key: key);

  @override
  _Example_distanceState createState() => _Example_distanceState();
}

class _Example_distanceState extends State<Example_distance> {
  double default_W = 18;
  double default_H = 100;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  double set_W = 48;
  double set_H = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                height: 400,
                width: 350,
                color: Colors.amber.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: AnimatedContainer(
                        // Use the properties stored in the State class.
                        width: default_W,
                        height: default_H,
                        decoration: BoxDecoration(
                          color: _color,
                          borderRadius: _borderRadius,
                        ),
                        // Define how long the animation should take.
                        duration: const Duration(seconds: 1),
                        // Provide an optional curve to make the animation feel smoother.
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                    SizedBox(width: 50),
                    Container(
                      child: AnimatedContainer(
                        // Use the properties stored in the State class.
                        width: set_W,
                        height: set_H,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade500,
                          borderRadius: _borderRadius,
                        ),
                        // Define how long the animation should take.
                        duration: const Duration(seconds: 1),
                        // Provide an optional curve to make the animation feel smoother.
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(height: 50),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Btn_up(),
                    SizedBox(width: 25),
                    Btn_down(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Btn_reset(),
                    SizedBox(width: 25),
                    Btn_submit(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Btn_up() {
    return Container(
      color: Colors.blue.shade700,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            if ((default_H > 100) && (default_H < 380)) {
              default_H = default_H + 20;
              default_W = default_W + 3;
              print(default_H);
              print(default_W);
              print("Zoom enable");
            } else if (default_H > 380) {
              default_H = default_H - 20;
              default_W = default_W - 3;
              print("max");
            }
          });
        },
        child: Text(
          "UP",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
    );
  }

  Widget Btn_down() {
    return Container(
      color: Colors.blue.shade700,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            if ((default_H > 100) && (default_H < 380)) {
              default_H = default_H - 20;
              default_W = default_W - 3;
              print(default_H);
              print(default_W);
              print("Zoom enable");
            } else if (default_H <= 100) {
              default_H = default_H + 20;
              default_W = default_W + 3;
              print("max");
            }
          });
        },
        child: Text(
          "DOWN",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
    );
  }

  Widget Btn_reset() {
    return Container(
      color: Colors.blue.shade700,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            default_H = 150;
            default_W = 24;
            print(default_H);
            print(default_W);
          });
        },
        child: Text(
          "RESET",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
    );
  }

  Widget Btn_submit() {
    return Container(
      color: Colors.blue.shade700,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            if ((default_H >= 260) && (default_H <= 340)) {
              //print("PASS");

            } else {
              print("Don't pass");
            }
          });
        },
        child: Text(
          "SUBMIT",
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
    );
  }

  void Pass_dialog() {
    
  }
}
