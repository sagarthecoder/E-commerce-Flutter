import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-info.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-list.dart';

abstract class ProductInterface {
  Future<List<String>?> fetchProductCategories();
  Future<List<ProductInfo>?> fetchAllProducts();
  Future<ProductInfo?> fetchSingleProduct(String productId);
  Future<List<ProductInfo>?> fetchProductFromCategory(String categoryName);
}
