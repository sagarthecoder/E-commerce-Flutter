import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/helper/cart-helper.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/interfaces/product-interface.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-info.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductInterface service;
  ProductController({required this.service});
  final categories = <String>[].obs;
  final allProducts = <ProductInfo>[].obs;
  final searchedProducts = <ProductInfo>[].obs;
  final cartProducts = <ProductInfo>[].obs;
  final isLoading = false.obs;

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

  Future<void> getAllCarts() async {
    final ids = await CartHelper.getCartItemIds();
    cartProducts.value = [];
    for (var id in ids) {
      final product = await getProduct(id);
      if (product == null) continue;
      cartProducts.add(product);
    }
  }

  Future<List<ProductInfo>> getProducts(String categoryName) async {
    isLoading.value = true;
    final list = await service.fetchProductFromCategory(categoryName) ?? [];
    isLoading.value = false;
    return list;
  }

  Future<ProductInfo?> getProduct(int id) async {
    isLoading.value = true;
    final product = await service.fetchSingleProduct(id.toString());
    isLoading.value = false;
    return product;
  }

  Future<void> addToCart(int? id) async {
    if (id == null) return;
    isLoading.value = true;
    await CartHelper.addCartItemId(id);
    final item = await getProduct(id);
    isLoading.value = false;
    if (item == null) return;
    cartProducts.add(item);
  }

  Future<void> removeFromCart(int? id) async {
    if (id == null) return;
    isLoading.value = true;
    await CartHelper.removeCartItemId(id);
    final item = await getProduct(id);
    isLoading.value = false;
    if (item == null) return;
    cartProducts.removeWhere((product) => product.id == id);
  }

  bool isProductInCart(int? id) {
    if (id == null) return false;
    return cartProducts.any((product) => product.id == id);
  }
}
