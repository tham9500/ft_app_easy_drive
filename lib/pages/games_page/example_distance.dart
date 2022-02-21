import 'package:flutter/material.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:ft_app_easy_drive/pages/games_page/end_game/end_distance/fail_distance.dart';
import 'package:ft_app_easy_drive/pages/games_page/end_game/end_distance/success_distance.dart';
import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';
import 'package:ft_app_easy_drive/widget/dialog.dart';

class Example_distance extends StatefulWidget {
  Example_distance({Key? key}) : super(key: key);

  @override
  _Example_distanceState createState() => _Example_distanceState();
}

class _Example_distanceState extends State<Example_distance> {
  double default_W = 24;
  double default_H = 150;
  Color _color = Colors.lightGreen.shade400;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  double set_W = 12;
  double set_H = 75;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text("เกมส์ทดสอบสายตาทางลึก"),
        // ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: <Widget>[Btn_exit()],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 400,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                        SizedBox(width: 130),
                        Container(
                          child: AnimatedContainer(
                            // Use the properties stored in the State class.
                            width: set_W,
                            height: set_H,
                            decoration: BoxDecoration(
                              color: Colors.red,
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
                  Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "A",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 130),
                          Container(
                            child: Text(
                              "B",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Btn_up() {
    return Container(
      child: RaisedButton(
        color: Color.fromRGBO(43, 16, 132, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          setState(() {
            if ((default_H >= 45) && (default_H < 230)) {
              default_H = default_H + 1.25;
              default_W = default_W + 0.1875;
              print(default_H);
              print(default_W);
              print("Zoom enable");
            } else if (default_H >= 230) {
              default_H = 230;
              default_W = 36;
              print("max");
            }
          });
        },
        child: Icon(
          Icons.arrow_downward,
          color: Colors.white,
          size: 70,
        ),
      ),
    );
  }

  Widget Btn_down() {
    return Container(
      child: RaisedButton(
        color: Color.fromRGBO(43, 16, 132, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          setState(() {
            if ((default_H > 45) && (default_H <= 230)) {
              default_H = default_H - 1.25;
              default_W = default_W - 0.1875;
              print(default_H);
              print(default_W);
              print("Zoom enable");
            } else if (default_H <= 45) {
              default_H = 45;
              default_W = 7.5;
              print("max down");
            }
          });
        },
        child: Icon(
          Icons.arrow_upward,
          color: Colors.white,
          size: 70,
        ),
      ),
    );
  }

  Widget Btn_reset() {
    return Container(
      child: RaisedButton(
        color: Colors.orangeAccent.shade400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          setState(() {
            default_H = 150;
            default_W = 24;
            print(default_H);
            print(default_W);
          });
        },
        child: Icon(
          Icons.restart_alt,
          color: Colors.white,
          size: 70,
        ),
      ),
    );
  }

  Widget Btn_submit() {
    return Container(
      child: RaisedButton(
        color: Colors.green.shade400,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          setState(() {
            if ((default_H >= 60) && (default_H <= 80)) {
              print("PASS");
              // ignore: void_checks
              // _showMyDialogPass("ผ่าน");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Success_distance()));
            } else {
              print("Don't pass");
              // _showMyDialogFail("ไม่ผ่าน");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Fail_distance()));
            }
          });
        },
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 70,
        ),
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
                      "หากออกหรือปิดแอพพลิเคชัน\nระหว่างการทดสอบการ\nทดสอบจะสิ้นสุดลง",
                      style: TextStyle(color: Colors.black, fontSize: 16),
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

  Future<void> _showMyDialogFail(content) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade200,
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  child: Center(
                    child: Text("$content"),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('ออก'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Home_game()));
              },
            ),
            MaterialButton(
              child: const Text('เล่นใหม่'),
              onPressed: () {
                setState(() {
                  default_H = 150;
                  default_W = 24;
                  print(default_H);
                  print(default_W);
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Example_distance()));
              },
            ),
          ],
        );
      },
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
}
