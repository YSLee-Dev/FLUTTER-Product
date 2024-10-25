import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'ProductModel.freezed.dart';
part 'ProductModel.g.dart';

@freezed
class ProductModel with _$ProductModel {
  factory ProductModel({
    required int id,
    required String title,
    required String description,
    double? price,
    double? discountPercentage,
    String? thumbnail,
    List<String>? tags,
    String? brand,
    required int stock,
    List<ProductReviewModel>? reviews,
    List<String>? images,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

@freezed
class ProductReviewModel with _$ProductReviewModel {
  factory ProductReviewModel({
    required String comment,
    required String name,
    required String date,
  }) = _ProductReviewModel;

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) => _$ProductReviewModelFromJson(json);
}