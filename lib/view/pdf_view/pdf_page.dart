import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class PdfView extends StatefulWidget {
  final String title;
  final String path;

  const PdfView({Key key, this.title, this.path}) : super(key: key);

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {

  @override
  Widget build(BuildContext context) {

    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      path:  widget.path,
    );
  }


}
