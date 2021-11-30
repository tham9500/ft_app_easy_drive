import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';

class Screen_main extends StatefulWidget {
  Screen_main({Key? key}) : super(key: key);

  @override
  _Screen_mainState createState() => _Screen_mainState();
}

class _Screen_mainState extends State<Screen_main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text("เกมส์ทดสอบตามบอดสี"),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                child: Row(
                  children: <Widget>[Btn_exit()],
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    "จงตอบคำถามให้ถูกต้อง",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(13, 59, 102, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
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
                                builder: (context) => Home_login()));
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
