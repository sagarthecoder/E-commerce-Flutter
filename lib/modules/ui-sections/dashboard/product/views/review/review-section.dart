import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/product-controller.dart';

class ReviewSection extends StatelessWidget {
  final int productId;
  final _controller = Get.find<ProductController>();

  ReviewSection({
    required this.productId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.fetchReviews(productId);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Customer Reviews",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Obx(
          () => _controller.reviews.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("No reviews yet. Be the first to review!"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _controller.reviews.length,
                  itemBuilder: (context, index) {
                    final review = _controller.reviews[index];
                    return ListTile(
                      leading: Icon(Icons.person, color: Colors.grey[600]),
                      title: Text(
                        "User ${index + 1}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        review,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    );
                  },
                ),
        ),
        _buildAddReviewButton(),
      ],
    );
  }

  Widget _buildAddReviewButton() {
    final TextEditingController reviewController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: reviewController,
              decoration: InputDecoration(
                hintText: 'Write a review...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blueAccent),
            onPressed: () async {
              if (reviewController.text.isNotEmpty) {
                await _controller.addReview(productId, reviewController.text);
                reviewController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
