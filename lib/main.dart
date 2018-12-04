import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_2_go_final/theme/theme.dart';
import 'package:tech_2_go_final/view/contact/contact.dart';
import 'package:tech_2_go_final/view/home_page/home_page.dart';
import 'package:tech_2_go_final/view/list_pages/main_list_page.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(Tech2Go());
}

class Tech2Go extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(context),
      title: 'Tech 2 Go',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(
              title: 'Tech 2 Go',
            ),
        '/listPage': (context) => ListPage(
              title: 'Fusers',
            ),
        '/contactPage': (context) => ContactPage(),
      },
    );
  }
}
