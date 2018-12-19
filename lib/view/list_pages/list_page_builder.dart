import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tech_2_go_final/data/product.dart';
import 'package:tech_2_go_final/utilities/loading_dialog.dart';
import 'package:tech_2_go_final/utilities/widget_utils.dart'
    show screenAwareSize;
import 'package:tech_2_go_final/view/detail_page/detail_page.dart';
import 'package:tech_2_go_final/view/pdf_view/pdf_page.dart';

class ProductList extends StatelessWidget {
  final List<Product> allProducts;
  final String title;

  const ProductList({Key key, this.allProducts, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return title.toLowerCase() == 'fusers' || title.toLowerCase() == 'kits'
        ? FuserKitList(products: _parseProducts())
        : title.toLowerCase() == 'tips'
            ? TechTips(
                products: _parseProducts(),
              )
            : InstructionGroup(
                products: _parseProducts(),
              );
  }

  _parseProducts() {
    switch (title.toLowerCase()) {
      case 'fusers':
        return allProducts
            .where((product) => product.type.toLowerCase() == 'fuser')
            .toList();
      case 'kits':
        return allProducts
            .where((product) => product.type.toLowerCase() == 'kit')
            .toList();
      case 'tips':
        return allProducts
            .where((product) => product.type.toLowerCase() == 'tip')
            .toList();
      case 'instructions':
        return allProducts
            .where((product) => product.type.toLowerCase() == 'instruction')
            .toList();
      default:
    }
  }
}

class TechTips extends StatelessWidget {
  final List<Product> products;

  const TechTips({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = "https://www.laserpros.com/img/TechTips/";
    products.sort((a,b) => a.modelName.toLowerCase().compareTo(b.modelName.toLowerCase()));
    for (Product product in products) {
      product.list.sort((a,b) => a.toLowerCase().compareTo(b.toLowerCase()));
    }

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index){
        return Card(
          child: ExpansionTile(
            leading: Icon(
              Icons.print,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              products[index].modelName,
              style: TextStyle(fontSize: screenAwareSize(20.0, context)),
            ),
            children: products[index].list
                .map<Widget>((pdf) => _pdfListBuilder(context,
                _linkConvert(pdf), "$baseUrl$pdf.pdf"))
                .toList(),
          ),
        );
      },
    );
  }

  _linkConvert(String pdf) {
    return pdf.toUpperCase().replaceAll('-', ' ');
  }
}

class InstructionGroup extends StatelessWidget {
  final List<Product> products;

  const InstructionGroup({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = "https://www.laserpros.com/img/Instructions/";
    List<String> productGroups = [
      "HP Color LaserJet",
      "HP Monochrome LaserJet",
      "HP Multifunction LaserJet"
    ];

    List<Product> color = products
        .where((product) => product.group.toLowerCase().contains('color'))
        .toList();
    color.sort((a,b) => a.modelName.toLowerCase().compareTo(b.modelName.toLowerCase()));

    List<Product> mono = products
        .where((product) => product.group.toLowerCase().contains('mono'))
        .toList();
    mono.sort((a,b) => a.modelName.toLowerCase().compareTo(b.modelName.toLowerCase()));

    List<Product> multi = products
        .where((product) => product.group.toLowerCase().contains('multi'))
        .toList();
    multi.sort((a,b) => a.modelName.toLowerCase().compareTo(b.modelName.toLowerCase()));

    List<List<Product>> groupedProducts = [color, mono, multi];

    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ExpansionTile(
            leading: Icon(
              Icons.print,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              productGroups[index],
              style: TextStyle(fontSize: screenAwareSize(20.0, context)),
            ),
            children: groupedProducts[index]
                .map<Widget>((product) => _pdfListBuilder(context,
                    product.modelName, "$baseUrl${product.list[0]}.pdf"))
                .toList(),
          ),
        );
      },
      itemCount: groupedProducts.length,
    );
  }
}

_pdfListBuilder(BuildContext context, String title, String link) {
  return ListTile(
    contentPadding: EdgeInsets.only(
      left: screenAwareSize(35.0, context),
      right: screenAwareSize(15.0, context),
    ),
    leading: Icon(
      Icons.picture_as_pdf,
      color: Colors.red[900],
    ),
    title: Text(
      title,
      style: TextStyle(
          fontFamily: 'Montsserat',
          fontSize: screenAwareSize(15.0, context),
          fontWeight: FontWeight.bold),
    ),
    onTap: () async {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => LoadingDialog(),
      );
      File pdfFile = await _createFileOfPdfUrl(link);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PdfView(
                title: title,
                path: pdfFile.path,
              ),
        ),
      );
    },
  );
}

Future<File> _createFileOfPdfUrl(String url) async {
  final filename = "temp.pdf";
  var request = await HttpClient().getUrl(Uri.parse(url));
  var response = await request.close();
  var bytes = await consolidateHttpClientResponseBytes(response);
  String dir = (await getApplicationDocumentsDirectory()).path;
  File file = File('$dir/$filename');
  file.writeAsBytesSync(bytes);
  return file;
}

class FuserKitList extends StatelessWidget {
  final List<Product> products;

  const FuserKitList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    products.sort((a, b) =>
        a.modelName.toLowerCase().compareTo(b.modelName.toLowerCase()));

    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          String imageString =
              products[index].group.toLowerCase().replaceAll('-', '_');

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DetailPage(
                            heroTag: imageString,
                            product: products[index],
                          )));
            },
            child: Padding(
              padding: EdgeInsets.all(screenAwareSize(10.0, context)),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).primaryColor,
                    padding: EdgeInsets.all(screenAwareSize(15.0, context)),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            products[index].modelName,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montsserat',
                                fontSize: screenAwareSize(18.0, context),
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            products[index].group,
                            style: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Montsserat',
                                fontSize: screenAwareSize(15.0, context)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Material(
                      color: Colors.white,
//                            elevation: 2.0,
                      /*borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0)),*/
                      child: Image.asset(
                        'assets/images/product_images/$imageString.jpg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
