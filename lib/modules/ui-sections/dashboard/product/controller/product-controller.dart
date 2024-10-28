import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/interfaces/product-interface.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-info.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductInterface service;
  ProductController({required this.service});
  final categories = <String>[].obs;
  final allProducts = <ProductInfo>[].obs;
  Future<void> getCategories() async {
    final list = await service.fetchProductCategories();
    if (list == null) return;
    categories.value = list;
  }

  Future<void> getAllProducts() async {
    final products = await service.fetchAllProducts();
    if (products == null) return;
    print("product count = ${products.length})");
    allProducts.value = products;
  }
}
