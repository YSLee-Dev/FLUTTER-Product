import 'package:flutter_product/Component/Model/ProductModel.dart';

abstract class IProductManager {
  Future<List<ProductModel>> requestMainProduct(int page, int count);
}