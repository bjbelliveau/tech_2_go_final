class Product {
  final String modelName;
  final String group;
  final String type;
  final List<String> list;

  Product({this.modelName, this.group, this.type, this.list});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    var jsonExtra = parsedJson["Extras"];
    List<String> productExtraList = jsonExtra.cast<String>();

    return Product(
        modelName: parsedJson["ModelName"],
        group: parsedJson["Group"],
        type: parsedJson["Type"],
        list: productExtraList);
  }
}
