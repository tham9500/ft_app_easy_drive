import 'package:ft_app_easy_drive/pages/load_pages/load.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Intl.defaultLocale = "th";

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('th', 'TH'),
        ],
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
