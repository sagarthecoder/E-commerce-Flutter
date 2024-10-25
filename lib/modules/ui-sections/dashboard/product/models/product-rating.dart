import 'package:json_annotation/json_annotation.dart';
part 'product-rating.g.dart';

@JsonSerializable()
class ProductRating {
  final double? rate;
  final int? count;
  ProductRating({this.rate, this.count});
  factory ProductRating.fromJson(Map<String, dynamic> json) =>
      _$ProductRatingFromJson(json);
  Map<String, dynamic> toJson() => _$ProductRatingToJson(this);
}
