import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: EdgeInsets.all(15.0),
      children: <Widget>[
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            'assets/images/skinnyglobe.png',
            height: 10.0,
          ),
        ),
        Text(
          'Loading...',
          style: TextStyle(fontSize: 25.0, fontFamily: 'Montsserat'),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
