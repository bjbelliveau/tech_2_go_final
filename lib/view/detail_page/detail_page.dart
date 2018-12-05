import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tech_2_go_final/data/product.dart';
import 'package:tech_2_go_final/utilities/widget_utils.dart';

class DetailPage extends StatefulWidget {
  final String heroTag;
  final Product product;

  const DetailPage({Key key, this.heroTag, this.product}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(1, 137, 185, 0.85),
      appBar: AppBar(
        title: Text(widget.product.modelName),
      ),
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
            Column(
              children: <Widget>[
                _getImageSlider(widget.product.type),
                _getCrossRef(),
              ],
            ),
            Spacer(),
            _getButton(),
          ],
        ),
      ),
    );
  }

  _getImageSlider(String type) {
    String urlPrefix = 'assets/images/product_images/';
    List<String> images = [
      urlPrefix + widget.heroTag + '.jpg',
      urlPrefix + widget.heroTag + '_2.jpg',
      urlPrefix + widget.heroTag + '_3.jpg',
      urlPrefix + widget.heroTag + '_4.jpg',
    ];

    return type.toLowerCase() == 'fuser'
        ? CarouselSlider(
            items: images.map((image) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Hero(
                    tag: widget.heroTag,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                  ),
                ),
              );
            }).toList(),
            viewportFraction: 0.9,
            aspectRatio: 16 / 9,
            initialPage: 0,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Hero(
                tag: widget.heroTag,
                child: Image.asset(
                  images[0],
                  fit: BoxFit.cover,
                  width: 1000.0,
                ),
              ),
            ),
          );

    /*return Hero(
      tag: widget.heroTag,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            images[0],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );*/
  }

  _getCrossRef() {
    return widget.product.list[0].isEmpty
        ? Container()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Color.fromRGBO(1, 137, 185, 0.85),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.0, 0.65],
                    tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Cross Reference',
                      style: TextStyle(
                          fontFamily: 'Montsserat',
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.product.list[0],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _getButton() {
    return Padding(
      padding: EdgeInsets.all(screenAwareSize(25.0, context)),
      child: RaisedButton(
        padding: EdgeInsets.all(screenAwareSize(15.0, context)),
        onPressed: () {},
        color: Theme.of(context).accentColor,
        elevation: 2.0,
        child: Text(
          "Find ${widget.product.group} on the web",
          style: TextStyle(
              color: Colors.white,
              fontSize: screenAwareSize(20.0, context),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
