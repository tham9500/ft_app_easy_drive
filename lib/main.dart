import 'package:ft_app_easy_drive/pages/load_pages/load.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //debug screen app
        theme: ThemeData(fontFamily: "Prompt"),
        title: 'easy drive',
        initialRoute: '/',
        routes: {
          '/': (context) => LoadApp_page(),
        },
      ),
    );
  }
}
