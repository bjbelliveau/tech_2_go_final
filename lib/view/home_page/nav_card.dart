import 'package:flutter/material.dart';
import 'package:tech_2_go_final/utilities/widget_utils.dart'
    show screenAwareSize;
import 'package:tech_2_go_final/view/list_pages/main_list_page.dart';

class NavCard extends StatefulWidget {
  final String title;

  const NavCard({Key key, this.title}) : super(key: key);

  @override
  _NavCardState createState() => _NavCardState();
}

class _NavCardState extends State<NavCard> {
  @override
  Widget build(BuildContext context) {
    String image = _getImageString(widget.title);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ListPage(
                      title: widget.title,
                      image: image,
                    )));
      },
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
               image,
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.25), BlendMode.multiply),
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0),
                elevation: 3.0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontFamily: 'Montsserat',
                        color: Colors.white,
                        fontSize: screenAwareSize(40.0, context),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _getImageString(String title) {
    String imagePrefix = 'assets/images';

    switch (title.toLowerCase()) {
      case 'fusers':
        return '$imagePrefix/fuser.jpg';
        break;
      case 'kits':
        return '$imagePrefix/kit.jpg';
        break;
      case 'tips':
        return '$imagePrefix/techtips.png';
        break;
      case 'instructions':
        return '$imagePrefix/instructions.jpg';
        break;
    }

    return null;
  }
}
