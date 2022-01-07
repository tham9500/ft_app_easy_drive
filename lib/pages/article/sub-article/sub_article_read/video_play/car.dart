import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/controller/article_test/video_car.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';

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
  // late VideoPlayerController videoPlayerController;
  // late ChewieController chewieController;

  void initState() {
    // TODO: implement initState
    super.initState();
    Check_status();
    video_data();
  }

  video_data() {
    data_video = formData.car;
    print(data_video.length);
    // print("list video = ${data_video[0]["clip_url"]}");
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
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: BetterPlayer.network(
                    "${Domain_name().forword_port}/easy_drive_backend/video/1640790649.mp4",
                    betterPlayerConfiguration: BetterPlayerConfiguration(
                      aspectRatio: 16 / 9,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
              // Container(
              //   child: Image.network(
              //       "http://10.0.2.2/easy_drive_backend/image/1641018645.jpg"),
              // ),
              // Container(
              //   child: AspectRatio(
              //     aspectRatio: 16 / 9,
              //     child: BetterPlayer.network(
              //       "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
              //       betterPlayerConfiguration: BetterPlayerConfiguration(
              //         aspectRatio: 16 / 9,
              //       ),
              //     ),
              //   ),
              // ),
              // Container(
              //   child: AspectRatio(
              //     aspectRatio: 16 / 9,
              //     child: BetterPlayer.file(
              //       "../../../../../../assets/video/1640790649.mp4",
              //       betterPlayerConfiguration: BetterPlayerConfiguration(
              //         aspectRatio: 16 / 9,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
