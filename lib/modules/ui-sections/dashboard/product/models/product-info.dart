import 'package:flutter_ecommerce/modules/ui-sections/dashboard/product/models/product-rating.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product-info.g.dart';

@JsonSerializable()
class ProductInfo {
  final String? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final ProductRating? rating;

  ProductInfo(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});
  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      _$ProductInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductInfoToJson(this);
}
