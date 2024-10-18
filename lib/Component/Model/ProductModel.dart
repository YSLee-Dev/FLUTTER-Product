import 'dart:ffi';

class ProductModel {
  int id;
  String title;
  String description;
  double? price;
  double? discountPercentage;
  String? thumbnail;
  List<String>? tags;
  String? brand;
  int stock;
  List<ProductReviewModel>? reviews;
  List<String>? images;

  ProductModel({
    required int this.id, required String this.title,
    required String this.description, double? this.price, double? this.discountPercentage,
    String? this.thumbnail, List<String>? this.tags,
    String? this.brand, required this.stock,
    List<ProductReviewModel>? this.reviews, List<String>? this.images
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        discountPercentage: double.parse(json['discountPercentage'].toString()),
        thumbnail: json['thumbnail'],
        tags: List<String>.from(json['tags' ?? []]),
        brand: json['brand'],
        stock: json['stock'],
        reviews: (json['reviews'] as List).map ((data) {
          return ProductReviewModel.fromJson(data);
        }).toList(),
       images: List<String>.from(json['images' ?? []])
    );
  }
}

class ProductReviewModel {
  String comment;
  String name;
  String date;

  ProductReviewModel({required this.comment, required this.name, required this.date});

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
        comment: json['comment'],
        name: json['reviewerName'],
        date: json['date']
    );
  }
}