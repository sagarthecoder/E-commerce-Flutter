import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-info.dart';

class ProductList {
  final List<ProductInfo>? list;
  ProductList({this.list});
  factory ProductList.fromJson(List<dynamic> parsedJson) {
    List<ProductInfo> parsedList =
        parsedJson.map((i) => ProductInfo.fromJson(i)).toList();
    return ProductList(list: parsedList);
  }
}
