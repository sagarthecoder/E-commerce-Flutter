import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/controller/product-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-info.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/views/product-detail/product-details-screen.dart';
import 'package:get/get.dart';

class PurchaseHistoryScreen extends StatelessWidget {
  final _controller = Get.find<ProductController>();

  PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(() => _buildHisotyGridView()),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Purchase History'),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildHisotyGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.8,
      ),
      itemCount: _controller.purchasedProducts.length,
      itemBuilder: (context, index) {
        final item = _controller.purchasedProducts[index];
        return _buildPurchaseItem(item, context);
      },
    );
  }

  Widget _buildPurchaseItem(ProductInfo item, BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductDetails(item),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: _purchaseItemDecoration(),
        child: Stack(
          children: [
            _buildPurchaseItemDetails(item),
            _buildDeleteIcon(item, context),
          ],
        ),
      ),
    );
  }

  BoxDecoration _purchaseItemDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          blurRadius: 10.0,
          spreadRadius: 5.0,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _buildPurchaseItemDetails(ProductInfo item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildItemImage(item),
        _buildItemTitle(item),
        _buildItemPrice(item),
      ],
    );
  }

  Widget _buildItemImage(ProductInfo item) {
    return CachedNetworkImage(
      imageUrl: item.image ?? "",
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: double.infinity,
      height: 120,
      fit: BoxFit.contain,
    );
  }

  Widget _buildItemTitle(ProductInfo item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        item.title ?? "",
        maxLines: 1,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildItemPrice(ProductInfo item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        '\$${(item.price ?? 0.0).toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 14,
          color: Colors.green,
        ),
      ),
    );
  }

  Widget _buildDeleteIcon(ProductInfo item, BuildContext context) {
    return Positioned(
      top: 8.0,
      right: 8.0,
      child: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          _controller.removeFromPurchaseHistory(item.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("${item.title} removed from Purchase History")),
          );
        },
      ),
    );
  }

  void _navigateToProductDetails(ProductInfo item) {
    Future.microtask(
        () => Get.to(() => ProductDetailsScreen(productInfo: item)));
  }
}