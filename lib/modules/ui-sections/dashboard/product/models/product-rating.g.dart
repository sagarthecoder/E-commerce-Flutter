// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product-rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductRating _$ProductRatingFromJson(Map<String, dynamic> json) =>
    ProductRating(
      rate: (json['rate'] as num?)?.toDouble(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductRatingToJson(ProductRating instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'count': instance.count,
    };
