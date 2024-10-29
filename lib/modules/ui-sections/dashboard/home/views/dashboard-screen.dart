import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/controller/product-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-category/product-category-view.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-list/product-list-view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DashboardScreen extends StatelessWidget {
  final _controller = Get.find<ProductController>();
  DashboardScreen({super.key}) {
    _controller.getCategories();
    _controller.getAllProducts();
    _controller.getAllCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: _buildScreen(),
          ),
          showLoaderIfNeeded()
        ],
      ),
    );
  }

  Widget _buildScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductCategoryView(),
        const SizedBox(
          height: 30,
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            "Recommended",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        _buildProducts(),
      ],
    );
  }

  Widget _buildProducts() {
    return Obx(() {
      return Expanded(
          child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: ProductListView(products: _controller.allProducts.value),
      ));
    });
  }

  Widget showLoaderIfNeeded() {
    return Obx(() {
      if (_controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    });
  }
}
