import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_product/Component/Network/MainDio.dart';
import 'package:flutter_product/Component/Network/ProductNetworkService.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../ProductManager/IProductManager.dart';
part 'NewProductManager.g.dart';


class NewProductManager implements IProductManager {
  ProductNetworkService _service;
  NewProductManager(ProductNetworkService service): _service = service;

  @override
  Future<List<ProductModel>> requestMainProduct(int page, int count) async {
    final data = await _service.requestMainList("${count}", "${page * 10}");
    return data.products;
  }

  @override
  Future<List<ProductModel>> requestSearchProduct({required int page, required String query, int count = 10}) async {
    final data =  await _service.requestQuerySearch(query, "${count}", "${page * 10}");
    return data.products;
  }
}

@Riverpod(keepAlive: true)
IProductManager newProductManager(NewProductManagerRef ref) {
  return NewProductManager(ProductNetworkService(ref.watch(MainDioProvider("https://dummyjson.com/"))));
}