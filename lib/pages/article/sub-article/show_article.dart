import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/controller/article_test/article_sign.dart';
import 'package:ft_app_easy_drive/models/article_sign.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/page_view.dart';
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
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subArticle();
  }

  subArticle() {
    print(widget.data);
    list_Subarticle = widget.data;
    // for (var i = 0; i < widget.data.length; i++) {
    //   index++;
    //   list_Subarticle.add(widget.data[i]["sub_article"]);
    // }
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
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Article_sign()));
            },
            icon: Icon(Icons.arrow_back_ios),
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
                Container(
                  child: Text(
                    "${widget.data["head"]}",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
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
                Btn_openPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Btn_openPage() {
    return Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            child: Text(
              "อ่านเพิ่มเติม",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              print("open page click");

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Page_view(list_Subarticle["sub_article"])));
              // postdataUser();

              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Registor_page()));
            }));
  }
}
