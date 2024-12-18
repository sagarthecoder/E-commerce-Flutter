import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/controller/product-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-category/product-category-item-view.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-screen/product-screen.dart';
import 'package:get/get.dart';

class ProductCategoryView extends StatelessWidget {
  final _controller = Get.find<ProductController>();
  ProductCategoryView({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Container(child: buildCategories());
  }

  Widget buildCategories() {
    return Obx(() {
      final categories = _controller.categories.value;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, top: 16),
            child: Text(
              "Categories",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: categories
                  .map((category) => ProductCategoryItemCell(
                      onTap: (name) => {gotoProductScreen(name)},
                      categoryName: category))
                  .toList(),
            ),
          ),
        ],
      );
    });
  }

  Future<void> gotoProductScreen(String categoryName) async {
    final products = await _controller.getProducts(categoryName);
    Future.microtask(() => Get.to(() => ProductScreen(products: products)));
  }
}
