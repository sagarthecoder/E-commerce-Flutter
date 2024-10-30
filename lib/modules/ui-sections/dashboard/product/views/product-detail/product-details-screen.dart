import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common-views/NetworkImageView.dart';
import '../../controller/product-controller.dart';
import '../../models/product-info.dart';
import '../checkout/checkout-screen.dart';
import '../review/review-section.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductInfo productInfo;
  final _controller = Get.find<ProductController>();

  ProductDetailsScreen({
    required this.productInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Product Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProductImage(),
            _buildProductInfo(),
            _buildCartButton(),
            _buildCheckoutButton(),
            ReviewSection(productId: productInfo.id ?? 0),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: NetworkImageView(
          url: productInfo.image ?? "",
          aspectType: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productInfo.title ?? "",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "\$${(productInfo.price ?? 0.0).toStringAsFixed(2)}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Category: ${productInfo.category ?? ""}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            productInfo.description ?? "",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() => AnimatedScale(
            scale: _controller.isProductInCart(productInfo.id) ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _controller.isProductInCart(productInfo.id)
                      ? _controller.removeFromCart(productInfo.id)
                      : _controller.addToCart(productInfo.id);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: _controller.isProductInCart(productInfo.id)
                      ? Colors.redAccent
                      : Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  _controller.isProductInCart(productInfo.id)
                      ? "Remove from Cart"
                      : "Add to Cart",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Get.to(() => CheckoutScreen()),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            "Checkout",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
