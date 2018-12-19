import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_2_go_final/repo/json_product_repo.dart';
import 'package:tech_2_go_final/view/list_pages/list_page_builder.dart';

class ListPage extends StatefulWidget {
  final String title;
  final String image;

  const ListPage({Key key, this.title, this.image}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 4;

    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              /*actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    print('Search');
                  },
                ),
              ],*/
              expandedHeight: height,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                title: Text(widget.title),
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.srcATop),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
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
          child: Center(
            child: FutureBuilder(
                future: JsonProductList().fetchProductData(),
                builder: (context, snapshot) {
                  print(snapshot.hasError ? snapshot.error : "Parsed Json");

                  return snapshot.hasData
                      ? ProductList(
                          title: widget.title,
                          allProducts: snapshot.data,
                        )
                      : CircularProgressIndicator();
                }),
          ),
        ),
      ),
    );
  }
}
