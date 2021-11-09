import 'dart:convert';
import 'dart:math';
import 'package:ft_app_easy_drive/models/eyecolor_quiz.dart';
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
  }

  examtotal() {
    var aaa = Question().questions;
    for (var i = 0; i < Question().questions.length; i++) {
      print(aaa[i]["ID"]);
      idExam.add(aaa[i]["ID"]);
    }
    print(idExam);
  }

  var test;
  List<dynamic> choice = [];
  List<dynamic> idExam = [];

  quizData() {
    print(" id  = ${idExam}");
    print("idExam = $idExam");
    choice.clear();
    late int totalexam = Question().questions.length;
    Random random = Random();
    print("totalexam = ${totalexam}");
    //int quiz_id = random.nextInt(totalexam);

    var quiz_id = (idExam..shuffle()).first;

    print("quiz_id = ${quiz_id}");

    for (var i = 0; i < idExam.length; i++) {
      if (idExam[i] == quiz_id) {
        idExam.removeAt(i);
        break;
      } else {
        continue;
      }
    }
    print("Realexam = ${idExam}");
    var result;
    //print(quiz_id);
    /*  var prefs = await SharedPreferences.getInstance();
    prefs.setInt('QUIZ_ID', quiz_id); */
    for (var i = 0; i < Question().questions.length; i++) {
      if (quiz_id == Question().questions[i]["ID"]) {
        result = Question().questions[i];
      }
    }
    print("result = ${result}");
    /* var user_id = (prefs.getInt('QUIZ_ID') ?? 0); */
    /*  print(user_id); */

    // print(result.runtimeType);
    // print("result = ${result["ID"].runtimeType}");
    //var test = result["ID"];

    //print(test.runtimeType);
    formData.ID = result["ID"].toString();
    print(result["image"].toString());
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

    print("a = $choice");

    /* print(result["answers"].runtimeType);
    print(formData.Answer.runtimeType); */
    /*  var r = [1, 2, 3];
    r.shuffle(); */
    /*  print(r); */

    /*  print(formData.image); */
    // print(formData.Answer);
    /*  print(formData.image); */
    /* ImageQuiz = formData.image; */
  }

  /*  Future<String> tests() async {
    if (test != null) {
      return test;
    } else {
      return "false";
    }
  } */

  @override
  Widget build(BuildContext context) {
    print("test = $test");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("เกมส์ทดสอบตามบอดสี"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                /*  child: FutureBuilder(
                future: tests(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == "false") {
                    return CircularProgressIndicator();
                  } else {
                    return Image.asset(snapshot.data);
                  }
                },
              ) */
                child: test != null
                    ? Image.asset(test)
                    : CircularProgressIndicator(),
              ),
              Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical, //defualt
                  shrinkWrap: true, //defualt
                  itemCount: choice.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.098,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.amber.shade300),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                child: Text("${choice[index]["text"]}"),
                                onPressed: () {
                                  //a[index]["text"];
                                  print("games colors click");
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
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names

}
