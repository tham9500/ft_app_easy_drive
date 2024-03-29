import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen_example extends StatefulWidget {
  Screen_example({Key? key}) : super(key: key);

  @override
  State<Screen_example> createState() => _Screen_exampleState();
}

class _Screen_exampleState extends State<Screen_example> {
  bool load = true;
  String displayID = "";
  String status = "";
  String id_article_cate_id = "";
  List<dynamic> list_example = [];
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  void initState() {
    // TODO: implement initState
    super.initState();

    Check_status();
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
      id_article_cate_id = preferences.getString("ID_ARTICLE_CATE_ID")!;
    });
    print("ID = ${displayID}");
    print("id_article_cate_id = ${id_article_cate_id}");
    get_example();
  }

  Future<Null> get_example() async {
    Dio dio = new Dio();
    String url =
        '${Domain_name().domain}/easy_drive_backend/test/mobile/get_answer.php?article_cate_id=${id_article_cate_id}';

    var response = await Dio().get(url);
    var data_example = json.decode(response.data);
    list_example = data_example;
    print("data : ${data_example}");
    setState(() {
      load = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "แนวข้อสอบ",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/appbars/appbar.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
            ),
          ),
          // title: Text(
          //   "ลงทะเบียนเข้าใช้งาน",
          //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
        ),
      ),
      body: load
          ? ShowProgress()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: PageView.builder(
                        controller: controller,
                        itemCount: list_example.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 15),
                                Qeustion_show(index),
                                // SizedBox(height: 15),
                                Spacer(),
                                Btn_page(index),
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

  Widget Qeustion_show(index) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "คำถาม",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: list_example[index]["image_question"] == ""
                ? Qeustion_NoImage(index)
                : Qeustion_HaveImage(index),
          ),
          SizedBox(height: 15),
          Container(
            child: list_example[index]["answers"][0]["image_choice"] == ""
                ? Choice_NoIamge(index)
                : Choice_HaveIamge(index),
          ),
        ],
      ),
    );
  }

  Widget Btn_page(index) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: FloatingActionButton(
        backgroundColor: Colors.amberAccent.shade700,
        child: Text("${index + 1}/${list_example.length}"),
        onPressed: () {
          zoomPictureDialog();
        },
      ),
    );
  }

  Widget Qeustion_NoImage(index) {
    //print("NO");
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "${index + 1}. ${list_example[index]["question"]}",
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
              "${index + 1}. ${list_example[index]["question"]}",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Image.network(
              "${Domain_name().domain}/easy_drive_backend/image/question/${list_example[index]["image_question"]}",
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
        scrollDirection: Axis.vertical, //defualt
        shrinkWrap: true, //defualt
        itemCount: list_example[index]["answers"].length,

        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  child: RichText(
                      text: TextSpan(children: [
                TextSpan(
                    text: "ตอบ ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontFamily: "Prompt",
                        fontSize: 18)),
                TextSpan(
                    text: "${list_example[index]["answers"][i]["choice"]}",
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontFamily: "Prompt",
                        fontSize: 18)),
              ]))
                  // child: Text(
                  //   "${list_example[index]["answers"][i]["choice"]}",
                  //   style: TextStyle(fontSize: 16),
                  // ),
                  ),
            ),
          );
        },
      ),
    );
  }

  Widget Choice_HaveIamge(index) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical, //defualt
        shrinkWrap: true, //defualt
        itemCount: list_example[index]["answers"].length,

        itemBuilder: (BuildContext context, int i) {
          return Container(
            child: list_example[index]["answers"][i]["value_choice"] == "1"
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "${list_example[index]["answers"][i]["choice"]}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Image.network(
                            "${Domain_name().domain}/easy_drive_backend/image/choice/${list_example[index]["answers"][i]["image_choice"]}",
                            width: 400,
                            height: 200,
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

  // Widget Choice_HaveIamge(index) {
  //   print("haveImage");
  //   return Container(
  //     child: Column(
  //       children: <Widget>[
  //         Container(
  //           child: list_example[index]["answers"][index]["choice"] == null
  //               ? Text(
  //                   "${list_example[index]["answers"][index]["choice"]}",
  //                   style: TextStyle(fontSize: 16),
  //                 )
  //               : null,
  //         ),
  //         Container(
  //           padding: const EdgeInsets.all(8),
  //           child: Image.network(
  //             "${Domain_name().domain}/easy_drive_backend/image/choice/${list_example[index]["answers"][index]["image_choice"]}",
  //             width: 300,
  //             height: 150,
  //             fit: BoxFit.contain,
  //             loadingBuilder: (context, child, loadingProgress) {
  //               if (loadingProgress == null) {
  //                 return child;
  //               }
  //               return Center(
  //                 child: LinearProgressIndicator(
  //                   value: loadingProgress.expectedTotalBytes != null
  //                       ? loadingProgress.cumulativeBytesLoaded /
  //                           loadingProgress.expectedTotalBytes!
  //                       : null,
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
        return Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Container(
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
                                itemCount: list_example.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Container(
                                    alignment: Alignment.center,
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
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ))),
                                      child: Text("${index + 1}"),
                                      onPressed: () {
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
                  ],
                ),
              ),
            ),
            Positioned(
              left: 1.0,
              top: 30.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.1,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  child: const Text(
                    'X',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
