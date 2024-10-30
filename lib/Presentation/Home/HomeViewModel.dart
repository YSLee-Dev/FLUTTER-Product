import 'package:flutter/foundation.dart';
import 'package:flutter_product/Component/Dependency/ProductManager//IProductManager.dart';
import 'package:flutter_product/Component/Dependency/ProductManager/ProductManager.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'HomeViewModel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  int nowPage = 0;
  final IProductManager _productManager;

  HomeViewModel({IProductManager? productManager})
   : _productManager = productManager ?? ProductManager();

  @override
  Future<List<ProductModel>> build() async {
    return await _requestProductList();
  }

  void addProductList() async {
    final requestValue = await _requestProductList();
    state = AsyncValue.data(state.value! + requestValue);
  }

  Future<List<ProductModel>> _requestProductList({int count = 10}) async {
    nowPage ++;
    print("${nowPage} ${count}");
    state =  AsyncLoading();

    return await _productManager.requestMainProduct(nowPage, count);
  }
}