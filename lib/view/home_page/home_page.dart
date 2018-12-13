import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:snaplist/snaplist.dart';
import 'package:tech_2_go_final/utilities/widget_utils.dart'
    show screenAwareSize;
import 'package:tech_2_go_final/view/home_page/nav_card.dart';
import 'package:tech_2_go_final/view/map_view/map.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> navCardList = [
    "Fusers",
    "Kits",
    "Tips",
    "Instructions",
  ];

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height * 0.80;
    double cardWidth = MediaQuery.of(context).size.width * 0.75;
    Size cardSize = Size(cardWidth, cardHeight);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(1, 137, 185, 0.85),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Colors.white,
                  Color.fromRGBO(1, 137, 185, 0.85),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.5, 1.0],
                tileMode: TileMode.mirror),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: cardSize.height,
                child: SnapList(
                  count: navCardList.length,
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          (MediaQuery.of(context).size.width - cardSize.width) /
                              2),
                  sizeProvider: (index, data) => cardSize,
                  separatorProvider: (index, data) =>
                      Size(screenAwareSize(25.0, context), 0.0),
                  builder: (context, index, data) {
                    return NavCard(
                      title: navCardList[index],
                    );
                  },
                ),
              ),
//              _contact(),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  _launchUrl(String deepLink, String urlString) async {
    if (deepLink != null && await canLaunch(deepLink)) {
      print('Launched DeepLink');
      await launch(deepLink);
    } else {
      print('Launched urlString');
      await launch(urlString);
    }
  }

  _bottomNavBar() {
    const iconSize = 25.0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Color.fromRGBO(1, 137, 185, 0.85),
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.0, 0.65, 1.0],
            tileMode: TileMode.mirror),
      ),
      height: screenAwareSize(60.0, context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
                onTap: () async {
                  await _launchUrl(null, 'tel:7153601703');
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: screenAwareSize(iconSize, context),
                  ),
                )),
          ),
          Expanded(
            child: GestureDetector(
                onTap: () async {
                  await _launchUrl(null,
                      'mailto:techsupp@laserpros.com?subject=Tech%Support%From%App');
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Icon(
                    Icons.email,
                    color: Colors.white,
                    size: screenAwareSize(iconSize, context),
                  ),
                )),
          ),
          Expanded(
            child: GestureDetector(
                onTap: () async {
                  await _launchUrl('fb://profile/104763316256227',
                      'https://www.facebook.com/laserpros/');
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Icon(
                    MdiIcons.facebook,
                    color: Colors.white,
                    size: screenAwareSize(iconSize, context),
                  ),
                )),
          ),
          Expanded(
            child: GestureDetector(
                onTap: () async {
                  await _launchUrl('twitter://user?user_id=61271282',
                      'https://twitter.com/LaserPros');
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Icon(
                    MdiIcons.twitter,
                    color: Colors.white,
                    size: screenAwareSize(iconSize, context),
                  ),
                )),
          ),
          Expanded(
            child: GestureDetector(
                onTap: () async {
                  await _launchUrl(null, 'https://www.linkedin.com');
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Icon(
                    MdiIcons.linkedin,
                    color: Colors.white,
                    size: screenAwareSize(iconSize, context),
                  ),
                )),
          ),
          Expanded(
            child: GestureDetector(
                onTap: () async {
                  await Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LpiMap()));
                },
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Icon(
                    MdiIcons.mapMarker,
                    color: Colors.white,
                    size: screenAwareSize(iconSize, context),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
