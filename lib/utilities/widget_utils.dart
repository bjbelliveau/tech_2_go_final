import 'package:flutter/material.dart';

const double baseHeight = 650.0;

double screenAwareSize(double size, BuildContext context) {
  return MediaQuery.of(context).size.height * size / baseHeight;
}