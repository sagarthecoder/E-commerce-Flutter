import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/controller/product-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-category/product-category-view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class DashboardScreen extends StatelessWidget {
  final _controller = Get.find<ProductController>();
  DashboardScreen({super.key}) {
    _controller.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ProductCategoryView(),
          ],
        ),
      ),
    );
  }
}
