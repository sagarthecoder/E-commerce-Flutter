import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product-controller.dart';
import '../product-list/product-list-view.dart';

class SearchScreen extends StatelessWidget {
  final ProductController _controller = Get.find<ProductController>();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Products'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _search(value);
                } else {
                  _controller.searchedProducts.clear();
                }
              },
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (_controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (_controller.searchedProducts.isEmpty) {
                return const Center(child: Text('No products found'));
              }
              return Expanded(
                child: _buildProducts(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildProducts() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ProductListView(products: _controller.searchedProducts),
    );
  }

  Future<void> _search(String name) async {
    final list = await _controller.getProducts(name);
    _controller.searchedProducts.assignAll(list);
  }
}
