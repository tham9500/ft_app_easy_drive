import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class View_uncorrect extends StatefulWidget {
  View_uncorrect({Key? key}) : super(key: key);

  @override
  State<View_uncorrect> createState() => _View_uncorrectState();
}

class _View_uncorrectState extends State<View_uncorrect> {
  bool load = true;
  List<dynamic> Quiz = [];
  String condition = "";
  int maxScore = 0;
  String displayID = "";
  String status = "";

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
      String list_data = preferences.getString("LIST_QUIZ")!;
      Quiz = jsonDecode(list_data);
      maxScore = preferences.getInt("MAX_SCORE")!;
      condition = preferences.getString("CONDITION")!;
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
      load = false;
    });
    print("ID = ${displayID}");
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
          actions: <Widget>[],
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    child: ListView.builder(
                      // scrollDirection: Axis.vertical, //defualt
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,

                      itemCount: Quiz.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Column(
                            children: [
                              Qeustion_show(index),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget Btn_exit() {
    return Container(
      child: IconButton(
        color: Colors.red,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home_login()));
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget text_And() {
    return Container(
      child: Text(
        "ตอบ",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
    );
  }

  Widget Qeustion_NoImage(index) {
    //print("NO");
    return Container(
      alignment: Alignment.centerLeft,
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
            alignment: Alignment.centerLeft,
            child: Text(
              "${index + 1}. ${Quiz[index]["question"]}",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            child: Image.network(
              "${Domain_name().domain}/easy_drive_backend/image/question/${Quiz[index]["image_question"]}",
              width: 400,
              height: 200,
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
    print("noImage");
    return Container(
      child: ListView.builder(
        //defualt
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true, //defualt
        itemCount: Quiz[index]["answers"].length,

        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Quiz[index]["answers"][i]["value_choice"] == "1"
                  ? Container(
                      child: RichText(
                          text: TextSpan(children: [
                      TextSpan(
                          text: "ตอบ ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontFamily: "Prompt",
                              fontSize: 16)),
                      TextSpan(
                          text: "${Quiz[index]["answers"][i]["choice"]}",
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontFamily: "Prompt",
                              fontSize: 16)),
                    ]))
                      // child: Text(" ${Quiz[index]["answers"][i]["choice"]}",
                      //     style: TextStyle(
                      //         fontSize: 16, color: Colors.blue.shade900)),

                      // color: Colors.amber.shade200,
                      )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget text_Ans() {
    return Container(
      child: Text(
        "ตอบ",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }

  Widget Choice_HaveIamge(index) {
    print("haveImage");
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: Quiz[index]["answers"].length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: Quiz[index]["answers"][i]["value_choice"] == "1"
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "${Quiz[index]["answers"][i]["choice"]}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.network(
                            "${Domain_name().domain}/easy_drive_backend/image/choice/${Quiz[index]["answers"][i]["image_choice"]}",
                            width: 200,
                            height: 100,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: LinearProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
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
                  )
                : null,
          );
        },
      ),
    );
  }
}
