import 'dart:convert';
// import 'dart:html';
import 'dart:math';
import 'package:ft_app_easy_drive/models/eyecolor_quiz.dart';
import 'package:ft_app_easy_drive/pages/games_page/end_game/end_color/color_fail2.dart';
import 'package:ft_app_easy_drive/pages/games_page/end_game/end_color/color_firstfail.dart';
import 'package:ft_app_easy_drive/pages/games_page/end_game/end_color/color_pass.dart';
import 'package:ft_app_easy_drive/pages/games_page/home_game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../controller/example_color/eyecolor_control.dart';

class example_eyecolo extends StatefulWidget {
  example_eyecolo({Key? key}) : super(key: key);

  @override
  _example_eyecoloState createState() => _example_eyecoloState();
}

class _example_eyecoloState extends State<example_eyecolo> {
  Quizeye_data formData = Quizeye_data();
  /*  var ImageQuiz; */
  @override
  void initState() {
    super.initState();
    examtotal();
    quizData();
    //condition_ans();
    //end_quiz();
  }

  examtotal() {
    var aaa = Question().questions;
    for (var i = 0; i < Question().questions.length; i++) {
      idExam.add(aaa[i]["ID"]);
    }
  }

  var test;
  List<dynamic> choice = [];
  List<dynamic> idExam = [];
  List<dynamic> answer = [];
  List<dynamic> selecter = [];
  int count = 1;
  int condition = 0;
  int counting = 0;
  quizData() {
    choice.clear();
    idExam.shuffle();
    print("idExam SUFFLE = $idExam");
    late int totalexam = Question().questions.length;
    var quiz_id = (idExam..shuffle()).first;
    for (var i = 0; i < idExam.length; i++) {
      if (idExam[i] == quiz_id) {
        idExam.removeAt(i);
        if (idExam.length == 2) {
          for (var i = 0; i < idExam.length; i++) {
            idExam.removeAt(i);
            print("remove complete");
          }
        } else {}
        break;
      } else {
        continue;
      }
    }
    if (idExam.length == 3) {
      for (var i = 0; i < idExam.length; i++) {
        idExam.removeAt(i);
        print("remove complete");
      }
    }

    var result;
    for (var i = 0; i < Question().questions.length; i++) {
      if (quiz_id == Question().questions[i]["ID"]) {
        result = Question().questions[i];
      }
    }
    print("result = ${result}");
    formData.ID = result["ID"].toString();
    formData.image = result["image"].toString();
    formData.Answer = result["answers"];
    test = result["image"].toString();
    setState(() {
      test = result["image"].toString();
    });
    for (var i = 0; i < formData.Answer.length; i++) {
      choice.add(formData.Answer[i]);
    }
    choice.shuffle();
    print("SUFFLE = $choice");
  }

  condition_ans() {
    for (int selection = 0; selection < answer.length; selection++) {
      //print("list ans");
      print("list answer = ${answer[selection]}");
      if ((answer[selection] == 0) && (condition != 2) && (condition != 3)) {
        this.condition = 0;
        print("ไม่บอด");
      } else if ((answer[selection] == 2) && (condition != 3)) {
        print('บอดสีแดงเขียว');
        this.condition = 2;
      } else if (answer[selection] == 3) {
        print('บอดทุกสี');
        this.condition = 3;
      }
    }
    print("CONDITION TOTAL ===>> ${condition}");
  }

  end_quiz() {
    if (answer.length == 3) {
      print("in condition");
      if (condition == 0) {
        print("pass");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Color_pass()));
      } else if (condition == 2) {
        print("fail");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Fail_Color()));
      } else {
        print("fail");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Color_fail2()));
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    print("test = $test");
    return Scaffold(
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
                    "จงเลือกคำตอบให้ตรงกับภาพ ",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromRGBO(13, 59, 102, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: test != null
                    ? Image.asset(test)
                    : CircularProgressIndicator(),
              ),
              SizedBox(height: 20),
              Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical, //defualt
                  shrinkWrap: true, //defualt
                  itemCount: choice.length,

                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: Text(
                                  "${choice[index]["text"]}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                onPressed: () {
                                  if (count == 3) {
                                    count + 0;
                                  } else {
                                    count++;
                                  }
                                  print("LENGHT list ANS= ${answer.length}");

                                  print("LENGHT count = ${count}");
                                  answer.add(choice[index]["score"]);
                                  counting++;
                                  print("counting list = ${counting}");
                                  print(choice[index]["score"]);
                                  print("answer = ${answer}");
                                  selecter.add(choice[index]["ID"]);
                                  if (counting >= 3) {
                                    condition_ans();
                                    end_quiz();
                                  } else {}

                                  setState(() {
                                    if (idExam.isNotEmpty) {
                                      quizData();
                                    } else {}
                                  });
                                })),
                        // color: Colors.amber.shade200,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              count_quiz()
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

  Widget count_quiz() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "${count}/3",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }  // ignore: non_constant_identifier_names

}
