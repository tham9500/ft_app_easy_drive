import 'package:ft_app_easy_drive/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class LoadApp_page extends StatefulWidget {
  LoadApp_page({Key? key}) : super(key: key);

  @override
  _LoadApp_pageState createState() => _LoadApp_pageState();
}

class _LoadApp_pageState extends State<LoadApp_page> {
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: Home_page(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/load/load.gif",
      backgroundColor: Colors.white,
    );
  }
}