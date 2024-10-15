class ProductModel {
  int id;
  String title;
  String description;
  double? price;
  String? thumbnail;
  List<String>? tags;

  ProductModel({
    required int this.id, required String this.title,
    required String this.description, double? this.price,
    String? this.thumbnail, List<String>? this.tags
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      thumbnail: json['thumbnail'],
      tags: List<String>.from(json['tags' ?? []])
  );
  }
}