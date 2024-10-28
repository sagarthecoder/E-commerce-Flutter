import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/controller/product-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-detail/product-details-screen.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-list/product-cell.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../models/product-info.dart';

class ProductListView extends StatelessWidget {
  final List<ProductInfo> products;
  final _controller = Get.find<ProductController>();
  ProductListView({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildProductListUI(),
      ],
    );
  }

  Widget _buildProductListUI() {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCell(
            onTap: (id) {
              _gotoDetailPage(id);
            },
            productInfo: products[index]);
      },
    );
  }

  Future<void> _gotoDetailPage(int? id) async {
    if (id == null) return;
    final info = await _controller.getProduct(id);
    if (info == null) return;
    Future.microtask(
        () => Get.to(() => ProductDetailsScreen(productInfo: info)));
  }
}
