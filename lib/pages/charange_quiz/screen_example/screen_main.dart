import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/controller/test_charange/test_chrrange.dart';
import 'package:ft_app_easy_drive/models/selcetchoice_model.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/guide_charange.dart';
import 'package:ft_app_easy_drive/pages/charange_quiz/screen_example/end_test.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen_main extends StatefulWidget {
  Screen_main({Key? key}) : super(key: key);

  @override
  _Screen_mainState createState() => _Screen_mainState();
}

class _Screen_mainState extends State<Screen_main> {
  bool load = true;
  var currentPageValue;
  var present_page;
  var jumpPosition;
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
  Charange data = Charange();
  final interval = const Duration(seconds: 1);

  int timerMaxSeconds = 0;
  final int timerMaxMinute = 0;
  String displayID = "";
  String status = "";
  int currentSeconds = 0;
  int currentMinute = 0;
  List<dynamic> Quiz = [];
  List<Select_choice> selections = [];
  List<dynamic> list_Ans = [];
  List<dynamic> tatol_ans = [];
  List<dynamic> setting_list = [];
  List<dynamic> article_list = [];

  // "pass_criteria":"1","set_time":"3600"
  int pass = 0;
  int score = 0;
  int maxScore = 0;

  String get timerText =>
      '${((timerMaxSeconds - ((timerMaxSeconds - currentSeconds) % 3600) ~/ 60) ~/ 3600).toString().padLeft(2, '0')}:${(((timerMaxSeconds - currentSeconds) % 3600) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int milliseconds = 0]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        //print(timer.tick);
        currentSeconds = timer.tick;
        // print(currentSeconds);
        if (timer.tick >= timerMaxSeconds) {
          count_score();
          timer.cancel();
        }
      });
    });
  }

  void initState() {
    // startTimeout();
    super.initState();
    Check_status();
    // Quiz_charage();
    // Choice();
  }

  Future<Null> Check_status() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      status = preferences.getString("STATUS")!;
    });
    if (status == "login") {
      print("login complete");
      User_data();
    } else {
      print("Not login");
    }
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayID = preferences.getString("ID")!;
    });
    print("ID = ${displayID}");
    get_quiz();
  }

  Future<Null> get_quiz() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/test/mobile/get_test.php';

    var response = await Dio().get(url);
    var data = json.decode(response.data);
    // print("data type ${data.runtimeType}");
    // print("data  ${json.decode(response.data)}");
    Quiz = data;
    for (int i = 0; i < 5; i++) {
      Quiz.shuffle();
    }

    Quiz_charage();
  }

  Quiz_charage() {
    print("data_list = ${Quiz.length}");
    for (int i = 0; i < Quiz.length; i++) {
      Quiz[i]["answers"].shuffle();
    }

    print("Quiz data total = ${Quiz}");
    Choice();
  }

  Choice() {
    for (var i = 0; i < Quiz.length; i++) {
      selections.add(Select_choice(Quiz[i]["question_id"], "0", "0"));
    }
    print(selections.length);
    // print("selection = ${selections.first.id_answers}");
    get_article_cate();
  }

  Future<Null> get_article_cate() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/test/mobile/get_article_cate_test.php';

    var response = await Dio().get(url);
    var data_article = json.decode(response.data);
    for (int i = 0; i < data_article.length; i++) {
      article_list.add({
        "article_cate_id": data_article[i]["article_cate_id"],
        "article_cate_name": data_article[i]["article_cate_name"],
        "score_cate": 0
      });
    }
    // article_list = data_article;
    print("data : ${setting_list}");

    print(pass);

    get_setting();
  }

  Future<Null> get_setting() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/exam_setting/mobile/get_setting.php';

    var response = await Dio().get(url);
    var data_setting = json.decode(response.data);
    setting_list = data_setting;
    print("data : ${setting_list}");
    pass = int.parse(setting_list[0]["pass_criteria"]);
    maxScore = int.parse(setting_list[0]["num_test"]);
    timerMaxSeconds = int.parse(setting_list[0]["set_time"]);
    print(pass);
    setState(() {
      load = false;
    });
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Btn_exit(),
          actions: <Widget>[
            Timer_count(),
          ],
          flexibleSpace: ClipRRect(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          shape: RoundedRectangleBorder(),
        ),
      ),
      body: load
          ? ShowProgress()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 687,
                      child: PageView.builder(
                        physics: ScrollPhysics(),
                        controller: controller,
                        itemCount: Quiz.length,
                        itemBuilder: (context, index) {
                          //print(Quiz[index]["ID"]);
                          return Container(
                            child: Column(
                              children: <Widget>[
                                Qeustion_show(index),
                                Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Quiz.last == Quiz[index]
                                            ? Submit_test(index)
                                            : null,
                                      ),
                                      SizedBox(width: 15),
                                      Container(
                                        child: FloatingActionButton(
                                          backgroundColor:
                                              Colors.amberAccent.shade700,
                                          child: Icon(Icons.list_alt),
                                          onPressed: () {
                                            zoomPictureDialog();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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

  Widget Btn_Quiz() {
    return FloatingActionButton(onPressed: () {});
  }

  Widget Btn_exit() {
    return Container(
      child: IconButton(
        color: Colors.red,
        onPressed: () {
          _showMyDialogPass("ออก");
        },
        icon: Icon(
          Icons.exit_to_app,
          size: 35,
        ),
      ),
    );
  }

  Widget Qeustion_show(index) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Quiz[index]["image_question"] == ""
                  ? Qeustion_NoImage(index)
                  : Qeustion_HaveImage(index),
            ),
            Container(
              child: Quiz[index]["answers"][0]["image_choice"] == ""
                  ? Choice_NoIamge(index)
                  : Choice_HaveIamge(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget Qeustion_NoImage(index) {
    //print("NO");
    return Container(
      child: Text(
        "${index + 1}. ${Quiz[index]["question"]}",
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget Qeustion_HaveImage(index) {
    //print("YES");
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "${index + 1}. ${Quiz[index]["question"]}",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            child: Image.network(
              "${Domain_name().domain}/easy_drive_backend/image/question/${Quiz[index]["image_question"]}",
              width: 350,
              height: 150,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: LinearProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget Choice_NoIamge(index) {
    print("select on= ${selections[index].id_answers}");
    print("noImage");
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical, //defualt
        shrinkWrap: true, //defualt
        itemCount: Quiz[index]["answers"].length,

        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor: selections[index].id_answers != '0' &&
                                Quiz[index]["answers"][i]["choice_id"] ==
                                    selections[index].id_answers
                            ? MaterialStateProperty.all<Color>(Colors.green)
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: Text(
                      "${i + 1}. ${Quiz[index]["answers"][i]["choice"]}",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      if (index != Quiz.length - 1) {
                        controller.jumpToPage(index + 1);
                      } else {
                        print("condition Last page");
                      }
                      setState(() {
                        selections[index] = Select_choice(
                            Quiz[index]["question_id"],
                            Quiz[index]["answers"][i]["choice_id"],
                            Quiz[index]["answers"][i]["value_choice"]);
                      });
                    }

                    // color: Colors.amber.shade200,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget Choice_HaveIamge(index) {
    print("select on= ${selections[index].id_answers}");
    print("haveImage");
    return Container(
      child: GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
        ), //defualt
        itemCount: Quiz[index]["answers"].length,

        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        backgroundColor: selections[index].id_answers != '0' &&
                                Quiz[index]["answers"][i]["choice_id"] ==
                                    selections[index].id_answers
                            ? MaterialStateProperty.all<Color>(Colors.green)
                            : MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "${i + 1}. ${Quiz[index]["answers"][i]["choice"]}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Image.network(
                              "${Domain_name().domain}/easy_drive_backend/image/choice/${Quiz[index]["answers"][i]["image_choice"]}",
                              width: 350,
                              height: 150,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child: LinearProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (index != Quiz.length - 1) {
                        controller.jumpToPage(index + 1);
                      } else {
                        print("condition Last page");
                      }
                      setState(() {
                        selections[index] = Select_choice(
                            Quiz[index]["question_id"],
                            Quiz[index]["answers"][i]["choice_id"],
                            Quiz[index]["answers"][i]["value_choice"]);
                      });
                    }

                    // color: Colors.amber.shade200,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget Btn_quiz(index) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 100,
            width: 100,
            child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                child: Text(
                  "${[index + 1]}",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  //selections.replaceRange(index,index,Select_choice(Quiz[index]["ID"], Quiz[index]["answers"][i]["ID"]));
                }

                // color: Colors.amber.shade200,
                ),
          ),
        ),
      ),
    );
  }

  Widget Timer_count() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(
              Icons.access_alarm,
              color: Colors.red,
              size: 30,
            ),
          ),
          SizedBox(width: 15),
          Container(
            child: Text(
              "${timerText} ",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            alignment: Alignment.centerRight,
          ),
        ],
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
                      "หากออกจากการทำสอบ\nระหว่างการทดสอบ การทดสอบ\nจะสิ้นสุดลง",
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
                        Quiz.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Guide_charange()));
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

  Future<void> zoomPictureDialog() async {
    showGeneralDialog(
      context: context,
      barrierColor: Colors.black12.withOpacity(0.6), // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      // transitionDuration: const Duration(
      //     milliseconds:
      //         400), // How long it takes to popup dialog after button click
      pageBuilder: (_, __, ___) {
        // Makes widget fullscreen
        return SizedBox.expand(
          child: Column(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 70,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: Quiz.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return Container(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.black),
                                      backgroundColor: selections[index]
                                                  .id_answers !=
                                              "0"
                                          ? MaterialStateProperty.all<Color>(
                                              Colors.lightGreen.shade500)
                                          : MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ))),
                                  child: Text("${index + 1}"),
                                  onPressed: () {
                                    print(
                                        "condition floating BTN = ${selections[index].id_answers}");
                                    controller.jumpToPage(index);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                // decoration: BoxDecoration(
                                //     color: Colors.amber,
                                //     borderRadius: BorderRadius.circular(15)),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget Submit_test(index) {
    return Container(
      width: 280,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.green.shade500),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ))),
        child: Text(
          "ส่งข้อสอบ",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        onPressed: () {
          setState(() {
            timerMaxSeconds = 0;
          });

          tatol_ans.clear();
          // count_score();

          print("all select ${selections.length}");
        },
      ),
    );
  }

  count_score() {
    for (int i = 0; i < Quiz.length; i++) {
      for (int a = 0; a < selections.length; a++) {
        if (selections[a].id_quiz == Quiz[i]["question_id"]) {
          for (int ans = 0; ans < Quiz[i]["answers"].length; ans++) {
            if (selections[a].id_answers ==
                Quiz[i]["answers"][ans]["choice_id"]) {
              print("true");
              if (Quiz[i]["answers"][ans]["value_choice"] == "1") {
                score++;
                tatol_ans.add({
                  "question_id": selections[a].id_quiz,
                  "value_choice": "1"
                });
                print("true");

                for (int cate = 0; cate < article_list.length; cate++) {
                  if (article_list[cate]["article_cate_id"] ==
                      Quiz[i]["article_cate_id"]) {
                    print("true");
                    article_list[cate]["score_cate"] =
                        ++article_list[cate]["score_cate"];
                  }
                }
              } else {
                print("false");
                tatol_ans.add({
                  "question_id": selections[a].id_quiz,
                  "value_choice": "0"
                });
                list_Ans.add(Quiz[i]);
              }
            } else {}
          }
        } else if (selections[a].id_answers == "0") {
          tatol_ans
              .add({"question_id": selections[a].id_quiz, "value_choice": "0"});
          list_Ans.add(Quiz[i]);
          a = selections.length;
        }
      }
    }
    print("score = ${score}");
    print("tatol_ans ${tatol_ans}");
    print("article_score ${article_list}");

    regitorThead();
  }

  Future<Null> regitorThead() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/test/mobile/submit.php?user_id=$displayID';

    var dataReq = tatol_ans;

    var data = jsonEncode(dataReq);
    var response = await Dio().post(url, data: data);
    print(response.toString());
    try {
      print(url);

      if (response.toString() == 'complete') {
        checkService();
      } else if (response.toString() == 'error') {}
    } catch (e) {
      print("ERROR");
    }
  }

  Future<Null> checkService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var list_ans = jsonEncode(list_Ans);
    var list_article = jsonEncode(article_list);
    preferences.setString('LIST_QUIZ', list_ans);
    preferences.setInt('SCORE', score);
    preferences.setString('LIST_CATE', list_article);
    preferences.setInt('MAX_SCORE', maxScore);
    if (score >= pass) {
      print("pass");
      preferences.setString('CONDITION', "pass");
    } else {
      print("fail");
      preferences.setString('CONDITION', "fail");
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => End_test()));
  }
}
