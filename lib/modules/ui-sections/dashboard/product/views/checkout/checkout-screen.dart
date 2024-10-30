import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/controller/product-controller.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  final int productId;
  final RxBool isSubmitted = false.obs;
  final _controller = Get.find<ProductController>();
  CheckoutScreen({required this.productId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfo("User Address", "123 Street, City, Country"),
            _buildUserInfo("Mobile Number", "+123456789"),
            _buildUserInfo("Location", "City Center"),
            const Spacer(),
            _buildSubmitButton(),
            Obx(() => isSubmitted.value
                ? Center(
                    child: AnimatedOpacity(
                      opacity: isSubmitted.value ? 1.0 : 0.0,
                      duration: const Duration(seconds: 2),
                      child: const Text(
                        "Thanks for purchasing!",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : Container()),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo(String label, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            info,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await _submitOrder();
          isSubmitted.value = true;
          Future.delayed(const Duration(seconds: 3), () {
            isSubmitted.value = false;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          "Submit Order",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _submitOrder() async {
    await _controller.submitOrder(productId);
    print("Product $productId marked as purchased.");
  }
}
