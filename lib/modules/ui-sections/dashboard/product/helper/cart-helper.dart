import 'package:shared_preferences/shared_preferences.dart';

class CartHelper {
  static const String _cartKey = 'my_shop_cart';

  static Future<void> addCartItemId(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartIds = prefs.getStringList(_cartKey) ?? [];
    if (!cartIds.contains(id.toString())) {
      cartIds.add(id.toString());
      await prefs.setStringList(_cartKey, cartIds);
      print("ID $id added to cart.");
    } else {
      print("ID $id is already in the cart.");
    }
  }

  static Future<void> removeCartItemId(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartIds = prefs.getStringList(_cartKey) ?? [];
    if (cartIds.contains(id.toString())) {
      cartIds.remove(id.toString());
      await prefs.setStringList(_cartKey, cartIds);
      print("ID $id removed from cart.");
    } else {
      print("ID $id is not in the cart.");
    }
  }

  static Future<List<int>> getCartItemIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cartIds = prefs.getStringList(_cartKey) ?? [];
    return cartIds.map((id) => int.parse(id)).toList();
  }
}
