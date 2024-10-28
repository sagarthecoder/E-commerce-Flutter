import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/modules/ui-sections/common-views/NetworkImageView.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/controller/product-controller.dart';
import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-info.dart';
import 'package:get/get.dart';

class ProductCell extends StatelessWidget {
  final ProductInfo productInfo;

  ProductCell({required this.productInfo, super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          _buildImage(),
          _buildRating(),
        ],
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
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.star_border_purple500_sharp),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  (productInfo.rating?.rate ?? 0.0).toStringAsFixed(1),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 9,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
