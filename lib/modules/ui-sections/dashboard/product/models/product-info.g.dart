// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product-info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductInfo _$ProductInfoFromJson(Map<String, dynamic> json) => ProductInfo(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      category: json['category'] as String?,
      image: json['image'] as String?,
      rating: json['rating'] == null
          ? null
          : ProductRating.fromJson(json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductInfoToJson(ProductInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'description': instance.description,
      'category': instance.category,
      'image': instance.image,
      'rating': instance.rating,
    };
