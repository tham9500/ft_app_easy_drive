import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/controller/article_test/video_car.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Car_video extends StatefulWidget {
  const Car_video({Key? key}) : super(key: key);

  @override
  _Car_videoState createState() => _Car_videoState();
}

class _Car_videoState extends State<Car_video> {
  Video_car formData = Video_car();
  List<dynamic> data_video = [];
  String displayID = "";
  String status = "";

  void initState() {
    // TODO: implement initState
    super.initState();
    Check_status();
    video_data();
  }

  

  video_data() {
    data_video = formData.car;
    print(data_video.length);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              if (displayID == "") {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Home_page()));
              } else {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Home_login()));
              }
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
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Container(
                child: Text("data"),
              ),
              Container(
                child: Text("data"),
              ),
              Container(
                child: Text("data"),
              ),
              Container(
                child: Text("data"),
              ),
              Container(
                child: Text("data"),
              ),
              Container(
                child: Text("data"),
              ),
              Container(
                child: Text("data"),
              ),
              Container(
                child: Text("data"),
              ),
              Container(
                child: Text("data"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
