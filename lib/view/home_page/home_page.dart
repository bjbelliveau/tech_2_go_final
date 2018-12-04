import 'dart:io';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_drawer_handle/modal_drawer_handle.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snaplist/snaplist.dart';
import 'package:tech_2_go_final/utilities/widget_utils.dart'
    show screenAwareSize;
import 'package:tech_2_go_final/view/home_page/nav_card.dart';
import 'package:tech_2_go_final/view/map_view/map.dart';

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: screenAwareSize(25.0, context)),
                child: Container(
                  height: cardSize.height,
                  child: SnapList(
                    count: navCardList.length,
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width -
                                cardSize.width) /
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
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ModalDrawerHandle(
                            handleColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text('Phone support'),
                            onTap: () async {
                              Directory tempDir =
                                  await getApplicationDocumentsDirectory();
                              String path = tempDir.path;
                              print(path);
                            },
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: Icon(Icons.email,
                                color: Theme.of(context).primaryColor),
                            title: Text('E-mail support'),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => LpiMap()));
                            },
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: Icon(MdiIcons.facebook,
                                color: Theme.of(context).primaryColor),
                            title: Text('Follow us on Facebook'),
                            onTap: () {},
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: Icon(MdiIcons.twitter,
                                color: Theme.of(context).primaryColor),
                            title: Text('Follow us on Twitter'),
                            onTap: () {},
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: Icon(MdiIcons.linkedin,
                                color: Theme.of(context).primaryColor),
                            title: Text('Follow us on LinkedIn'),
                            onTap: () {},
                          ),
                        ),
                        Material(
                          child: ListTile(
                            leading: Icon(Icons.pin_drop,
                                color: Theme.of(context).primaryColor),
                            title: Text('Our Locations'),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          backgroundColor: Theme.of(context).primaryColor,
          label: Text('Contact'),
          icon: Icon(
            Icons.contact_phone,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
