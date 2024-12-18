import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/helper/product-db-helper.dart';
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
  var reviews = <String>[].obs;
  var purchasedProducts = <ProductInfo>[].obs;

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
    final ids = await ProductDBHelper.getCartItemIds();
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
    await ProductDBHelper.addCartItemId(id);
    final item = await getProduct(id);
    isLoading.value = false;
    if (item == null) return;
    cartProducts.add(item);
  }

  Future<void> removeFromCart(int? id) async {
    if (id == null) return;
    isLoading.value = true;
    await ProductDBHelper.removeCartItemId(id);
    final item = await getProduct(id);
    isLoading.value = false;
    if (item == null) return;
    cartProducts.removeWhere((product) => product.id == id);
  }

  bool isProductInCart(int? id) {
    if (id == null) return false;
    return cartProducts.any((product) => product.id == id);
  }

  Future<void> fetchReviews(int productId) async {
    final reviews = await ProductDBHelper.getReviews(productId);
    this.reviews.value = reviews;
  }

  Future<void> addReview(int productId, String reviewText) async {
    await ProductDBHelper.addReview(productId, reviewText);
    await fetchReviews(productId);
  }

  Future<void> submitOrder(int productId) async {
    isLoading.value = true;
    await ProductDBHelper.addPurchasedProductId(productId);
    final item = await getProduct(productId);
    isLoading.value = false;
    if (item == null) return;
    purchasedProducts.add(item);
  }

  Future<void> getPurchasedProducts() async {
    final ids = await ProductDBHelper.getPurchasedProductIds();
    purchasedProducts.value = [];
    for (var id in ids) {
      final product = await getProduct(id);
      if (product == null) continue;
      purchasedProducts.add(product);
    }
  }

  Future<void> removeFromPurchaseHistory(int? id) async {
    if (id == null) return;
    isLoading.value = true;
    await ProductDBHelper.removePurchaseItemId(id);
    final item = await getProduct(id);
    isLoading.value = false;
    if (item == null) return;
    purchasedProducts.removeWhere((product) => product.id == id);
  }
}
