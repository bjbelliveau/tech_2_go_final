import 'package:flutter/material.dart';

const Color primaryBlue = Color.fromRGBO(1, 52, 136, 1.0);

ThemeData buildTheme(BuildContext context) {
  const primaryColor = Color.fromRGBO(1, 52, 136, 1.0);
  const secondaryColor = Color.fromRGBO(224, 184, 11, 1.0);

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: primaryColor,
    accentColor: secondaryColor,
  );
}
