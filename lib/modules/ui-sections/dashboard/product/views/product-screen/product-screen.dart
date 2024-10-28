import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-list/product-list-view.dart';
import '../../models/product-info.dart';

class ProductScreen extends StatelessWidget {
  final List<ProductInfo> products;

  ProductScreen({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Our Products',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ProductListView(products: products),
      ),
    );
  }
}
