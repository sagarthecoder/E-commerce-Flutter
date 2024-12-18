import 'package:dio/dio.dart';
import 'package:flutter_ecommerce/modules/Constants/api-constants.dart';
import 'package:flutter_ecommerce/modules/service/api-service/network-service.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/interfaces/product-interface.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-info.dart';

class ProductService implements ProductInterface {
  @override
  Future<List<ProductInfo>?> fetchAllProducts() async {
    String url = APIConstant.allProductsURL();
    final result = await NetworkService.shared.genericApiRequest(
        url,
        RequestMethod.get,
        (item) => ProductInfo.fromJson(item as Map<String, dynamic>));
    return result?.data;
  }

  @override
  Future<List<String>?> fetchProductCategories() async {
    String url = APIConstant.categoriesURL;
    final result = await NetworkService.shared.genericApiRequest(
        url, RequestMethod.get, (item) => item.toString(),
        responseType: ResponseType.json);
    final data = result?.data;
    print("Data count = ${data?.length ?? -1}");
    return data;
  }

  @override
  Future<List<ProductInfo>?> fetchProductFromCategory(
      String categoryName) async {
    String url =
        APIConstant.productAtSpecificCategoryURL(categoryName: categoryName);
    final result = await NetworkService.shared.genericApiRequest(
        url,
        RequestMethod.get,
        (item) => ProductInfo.fromJson(item as Map<String, dynamic>));
    return result?.data;
  }

  @override
  Future<ProductInfo?> fetchSingleProduct(String productId) async {
    String url = APIConstant.singleProductURL(productId);
    final result = await NetworkService.shared.genericApiRequest(
        url,
        RequestMethod.get,
        (item) => ProductInfo.fromJson(item as Map<String, dynamic>));
    return result?.data?.first;
  }
}
