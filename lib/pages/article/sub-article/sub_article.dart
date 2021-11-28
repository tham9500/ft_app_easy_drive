import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/article/home_article.dart';

class Sub_article extends StatefulWidget {
  Sub_article({Key? key}) : super(key: key);

  @override
  _Sub_articleState createState() => _Sub_articleState();
}

class _Sub_articleState extends State<Sub_article> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_article()));
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
                          SizedBox(height: 30),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/logo/article-read.png"),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  child: Center(
                    child: Text(
                      "รอบรู้เรื่องการขับขี่",
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(13, 59, 102, 1)),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SubArticle_car(),
                SizedBox(height: 10),
                SubArticle_traffic(),
                SizedBox(height: 10),
                SubArticle_sign(),
                SizedBox(height: 10),
                SubArticle_manners(),
                SizedBox(height: 10),
                SubArticle_maintenance(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SubArticle_car() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(255, 255, 255, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 12),
                  Container(
                    width: 260,
                    child: Text(
                      "กฏหมายว่าด้วยรถยนต์\nและจักยานยนต์",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => example_eyecolo()));
            }));
  }

  Widget SubArticle_traffic() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(255, 255, 255, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 12),
                  Container(
                    width: 260,
                    child: Text(
                      "กฏหมายจราจรทางบก",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => example_eyecolo()));
            }));
  }

  Widget SubArticle_sign() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(255, 255, 255, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 12),
                  Container(
                    width: 260,
                    child: Text(
                      "เครื่องหมายจราจร",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => example_eyecolo()));
            }));
  }

  Widget SubArticle_manners() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(255, 255, 255, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 12),
                  Container(
                    width: 260,
                    child: Text(
                      "มารยาทและจิตสำนึก",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => example_eyecolo()));
            }));
  }

  Widget SubArticle_maintenance() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromRGBO(255, 255, 255, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Container(
              child: Row(
                children: <Widget>[
                  SizedBox(width: 12),
                  Container(
                    width: 260,
                    child: Text(
                      "การบำรุงรักษารถ",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    child: Container(
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              print("games colors click");
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => example_eyecolo()));
            }));
  }
}
