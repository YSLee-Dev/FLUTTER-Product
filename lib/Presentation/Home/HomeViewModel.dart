import 'package:flutter_product/Component/Dependency/ProductManager/NewProductManager.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'HomeViewModel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  int nowPage = 0;

  @override
  Future<List<ProductModel>> build() async {
    return await _requestProductList();
  }

  void addProductList() async {
    final requestValue = await _requestProductList();
    state = AsyncValue.data(state.value! + requestValue);
  }

  Future<List<ProductModel>> _requestProductList({int count = 10}) async {
    nowPage++;
    state = const AsyncLoading();

    // provider를 직접 사용
    final productManager = ref.read(newProductManagerProvider);
    return await productManager.requestMainProduct(nowPage, count);
  }
}
