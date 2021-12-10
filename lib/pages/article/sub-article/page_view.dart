import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/models/article_sign.dart';

class Page_view extends StatefulWidget {
  List<dynamic> data_page = [];
  Page_view(this.data_page, {Key? key}) : super(key: key);

  @override
  _Page_viewState createState() => _Page_viewState();
}

class _Page_viewState extends State<Page_view> {
  Sign_data formData = Sign_data();
  List<dynamic> list_text = [];
  List<dynamic> text = [];
  List<dynamic> img = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subArticle();
  }

  subArticle() {
    print(widget.data_page[0]);
    for (var i = 0; i < widget.data_page.length; i++) {
      list_text.add(widget.data_page[i]);
    }
    //for(var content = 0 ;content<widget.data_page.)
    print("data_page = ${widget.data_page}");
    print(list_text.runtimeType);
    print(list_text.length);
    print("list = ${list_text}");
    print("text = ${text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 700,
                          child: PageView.builder(
                            itemCount: list_text.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      child: list_text[index]['image'] != null
                                          ? Image_article(index)
                                          : Text("${list_text[index]['text']}"),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.all(18),
                                      child: SingleChildScrollView(
                                        child: Text(
                                            "${list_text[index]['text']}",
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Content() {
    return Container(
      child: PageView.builder(
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "${list_text[index]["text"]}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
