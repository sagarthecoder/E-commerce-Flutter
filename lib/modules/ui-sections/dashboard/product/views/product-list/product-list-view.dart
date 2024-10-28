import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-list/product-cell.dart';
import 'package:get/get.dart';

import '../../models/product-info.dart';

class ProductListView extends StatelessWidget {
  final List<ProductInfo> products;
  ProductListView({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 120,
          height: 170,
          child: ProductCell(productInfo: products[index]),
        );
      },
    );
  }
}
