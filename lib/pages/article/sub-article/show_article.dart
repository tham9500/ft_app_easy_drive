import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/controller/article_test/article_sign.dart';
import 'package:ft_app_easy_drive/models/article_sign.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article_read/article_sign.dart';

class Show_article extends StatefulWidget {
  var data;

  Show_article(this.data, {Key? key}) : super(key: key);

  @override
  _Show_articleState createState() => _Show_articleState();
}

class _Show_articleState extends State<Show_article> {
  Sign_data formData = Sign_data();
  var list_Subarticle; //OBJ
  List<dynamic> list_text = [];
  List<dynamic> text = [];
  List<dynamic> img = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subArticle();
    content();
  }

  content() {
    print(widget.data[0]);
    for (var i = 0; i < widget.data["sub_article"].length; i++) {
      list_text.add(widget.data["sub_article"][i]);
    }
    //for(var content = 0 ;content<widget.data_page.)
    print("data_page = ${widget.data}");
    print(list_text.runtimeType);
    print(list_text.length);
    print("list content = ${list_text}");
    print("text = ${text}");
  }

  subArticle() {
    print(widget.data);
    list_Subarticle = widget.data;

    print(list_Subarticle.runtimeType);
    print(list_Subarticle.length);
    print("list = ${list_Subarticle}");
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.data);
    //print(widget.data[0]["sub_article"]);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Article_sign()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "${widget.data["head"]}".length > 30
                ? "${widget.data["head"]}".substring(0, 30) + "..."
                : "${widget.data["head"]}",
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
                children: <Widget>[
                  Container(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // Container(
                                //   //padding: const EdgeInsets.all(12),
                                //   child: SafeArea(
                                //     child: Text(
                                //       "${widget.data["head"]}".length > 30
                                //           ? "${widget.data["head"]}"
                                //                   .substring(0, 30) +
                                //               "..."
                                //           : "${widget.data["head"]}",
                                //       style: TextStyle(
                                //           color: Colors.white,
                                //           fontSize: 20,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //   ),
                                // ),
                                // Container(
                                //   child: Text(
                                //     "เครื่องหมายนจราจร",
                                //     style: TextStyle(
                                //         fontSize: 28,
                                //         fontWeight: FontWeight.bold,
                                //         color: Colors.white),
                                //     textAlign: TextAlign.left,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            child: Text(
                              "",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.left,
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
      body: SafeArea(
        //child: Text("${widget.data[0]["sub_article"]}"),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                //First_page(),
                Container(
                    width: double.infinity,
                    height: 700,
                    child: PageView.builder(
                      itemCount: list_text.length,
                      itemBuilder: (context, index) {
                        print(list_text[index]["ID"]);
                        return Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: list_text[index]['ID'] == 1
                                    ? First_page(index)
                                    : Next_page(index),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget First_page(index) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "${widget.data["head"]}",
              style: TextStyle(
                  color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              "${widget.data["paragraph"]}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            child: list_text[index]['image'] != null
                ? Image_article(index)
                : Empty_image(),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "${list_text[index]['text']}",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget Next_page(index) {
    return Container(
      child: Column(
        children: [
          Container(
            child: list_text[index]['image'] != null
                ? Image_article(index)
                : Empty_image(),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "${list_text[index]['text']}",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget Empty_image() {
    return Container(
        // child: Text(
        //   "${list_text[index]['text']}",
        //   style: TextStyle(fontSize: 18),
        // ),
        );
  }

  Widget Image_article(index) {
    return Container(
      padding: const EdgeInsets.all(18),
      child: GestureDetector(
        child: Image(
          image: AssetImage("${list_text[index]["image"]}"),
        ),
        onTap: () {
          zoomPictureDialog(context, list_text[index]["image"]);
        },
      ),
    );
  }

  Future<void> zoomPictureDialog(BuildContext context, file) async {
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
              Expanded(
                flex: 5,
                child: SizedBox.expand(
                    child: Center(
                  child: InteractiveViewer(
                    panEnabled: true, // Set it to false
                    boundaryMargin: const EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 2,
                    // child: Image.file(
                    //   file,
                    //   width: MediaQuery.of(context).size.width,
                    //   height: MediaQuery.of(context).size.height,
                    //   fit: BoxFit.cover,
                    // ),
                    child: Image.asset(
                      file,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
              ),
            ],
          ),
        );
      },
    );
  }
}
