final class APIConstant {
  static const categoriesURL = "https://fakestoreapi.com/products/categories";
  static String allProductsURL({int limit = 0}) =>
      "https://fakestoreapi.com/products?limit=$limit";
  static String singleProductURL(String id) =>
      "https://fakestoreapi.com/products/$id";
  static String productAtSpecificCategoryURL(
          {required String categoryName, int limit = 0}) =>
      "https://fakestoreapi.com/products/category/$categoryName?limit=$limit";
}
