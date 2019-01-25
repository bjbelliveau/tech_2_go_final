import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tech_2_go_final/data/product.dart';

class JsonProductList {
  Future<List<Product>> fetchProductData() async {
    final response = await rootBundle.loadString('assets/json/products.json');

    return compute(parseProducts, response);
  }
}

List<Product> parseProducts(String message) {
  final parsed = json.decode(message).cast<Map<String, dynamic>>();

  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}
