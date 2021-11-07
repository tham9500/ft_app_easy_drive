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
  @override
  void initState() {
    super.initState();
    quizData();
  }

  quizData() async {
    late int totalexam = Question().questions.length;
    Random random = Random();
    int quiz_id = random.nextInt(totalexam);
    //print(quiz_id);
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('id_user', quiz_id);
    var result = Question().questions[quiz_id];
    print(result);
    print("result = ${result["ID"]}");
    var test = result["ID"];

    print(test.runtimeType);
    formData.ID = result["ID"].toString();
    formData.image = result["image"].toString();
    formData.Answer = result["answers"];
    print(formData.Answer);
  }

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset('assets/Example_Colors/plat1.png'),
              ),
              Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical, //defualt
                  shrinkWrap: true, //defualt
                  itemCount: 4,
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
                                child: Text("เกมส์ทดสอบตาบอดสี"),
                                onPressed: () {
                                  print("games colors click");
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
