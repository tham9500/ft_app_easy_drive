import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/pages/article/sub-article/video_aricle.dart';
import 'package:ft_app_easy_drive/widget/show_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Play_video extends StatefulWidget {
  Play_video({Key? key}) : super(key: key);

  @override
  _Play_videoState createState() => _Play_videoState();
}

class _Play_videoState extends State<Play_video> {
  bool load = true;
  String displayID = "";
  String status = "";
  String articleCate_id = "";
  String articleCate_name = "";
  List<dynamic> list_article = [];
  String id_video = "";
  String name_video = "";
  String head_video = "";
  String file_video = "";

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
      video_data();
    }
  }

  Future<Null> video_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_video = preferences.getString("VIDEO_ID")!;
      name_video = preferences.getString("VIDEO_NAME")!;
      head_video = preferences.getString("VIDEO_HEAD")!;
      file_video = preferences.getString("VIDEO_FILE")!;
      load = false;
    });
    print("ID_article = ${name_video}");
    // print("ID = ${cate_name}");
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayID = preferences.getString("ID")!;
    });
    print("ID = ${displayID}");
    video_data();
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Video_aricle()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(
            "${name_video}".length > 30
                ? "${name_video}".substring(0, 30) + "..."
                : "${name_video}",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
            ),
          ),
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
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Container(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer.network(
                          "${Domain_name().forword_port}/easy_drive_backend/video/${file_video}",
                          betterPlayerConfiguration: BetterPlayerConfiguration(
                            aspectRatio: 16 / 9,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Container(
                      child: Text("${head_video}"),
                    ),
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
