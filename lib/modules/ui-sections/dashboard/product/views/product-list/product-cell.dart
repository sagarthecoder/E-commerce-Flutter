import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/common-views/NetworkImageView.dart';
import '../../models/product-info.dart';

class ProductCell extends StatelessWidget {
  final ProductInfo productInfo;

  ProductCell({required this.productInfo, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            _buildImage(),
            _buildRating(),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildDescription(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    String? url = productInfo.image;
    if (url == null) {
      return Container();
    }
    return NetworkImageView(url: url);
  }

  Widget _buildRating() {
    return Positioned(
      top: 10,
      left: 10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.star, color: Colors.white, size: 16),
            SizedBox(width: 4),
            Text(
              (productInfo.rating?.rate ?? 0.0).toStringAsFixed(1),
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      color: Colors.black.withOpacity(0.7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            productInfo.title ?? "",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "\$${productInfo.price ?? 0.0}",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
