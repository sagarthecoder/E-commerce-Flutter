import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-info.dart';

class ProductCell extends StatelessWidget {
  final ProductInfo productInfo;
  ProductCell({required this.productInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 174.0,
    );
  }
}
