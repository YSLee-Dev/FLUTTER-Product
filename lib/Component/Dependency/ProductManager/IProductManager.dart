import 'package:flutter_product/Component/Model/ProductModel.dart';

abstract class IProductManager {
  Future<List<ProductModel>> requestMainProduct(int page, int count);
  Future<List<ProductModel>> requestSearchProduct({required int page, required String query, int count = 10}) ;
}