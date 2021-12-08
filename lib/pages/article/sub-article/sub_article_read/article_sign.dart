import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/sub_article.dart';

class Article_sign extends StatefulWidget {
  Article_sign({Key? key}) : super(key: key);

  @override
  _Article_signState createState() => _Article_signState();
}

class _Article_signState extends State<Article_sign> {
  int list_test = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Sub_article()));
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
                              "เครื่องหมายนจราจร",
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
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Container(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical, //defualt
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true, //defualt
                      itemCount: list_test,

                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
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
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ))),
                                    child: Text(
                                      "test",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    onPressed: () {})),
                            // color: Colors.amber.shade200,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
