// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductResponseModelImpl _$$ProductResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductResponseModelImpl(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductResponseModelImplToJson(
        _$ProductResponseModelImpl instance) =>
    <String, dynamic>{
      'products': instance.products,
    };

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num?)?.toDouble(),
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      thumbnail: json['thumbnail'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      brand: json['brand'] as String?,
      stock: (json['stock'] as num).toInt(),
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map(
                  (e) => ProductReviewModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'thumbnail': instance.thumbnail,
      'tags': instance.tags,
      'brand': instance.brand,
      'stock': instance.stock,
      'reviews': instance.reviews,
      'images': instance.images,
    };

_$ProductReviewModelImpl _$$ProductReviewModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductReviewModelImpl(
      comment: json['comment'] as String,
      name: json['reviewerName'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$$ProductReviewModelImplToJson(
        _$ProductReviewModelImpl instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'name': instance.name,
      'date': instance.date,
    };
