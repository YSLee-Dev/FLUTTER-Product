import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Component/Dependency/IProductManager.dart';
import '../../Component/Dependency/ProductManager.dart';
import '../../Component/Model/ProductModel.dart';
part 'SearchViewModel.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  int _nowPage = 0;
  bool _isWating = false;
  String watingWord = "";
  final IProductManager _productManager;

  SearchViewModel({IProductManager? productManager})
      : _productManager = productManager ?? ProductManager();

  @override
  Future<List<ProductModel>> build() async {
    return <ProductModel>[];
  }

  void querySearch({required String query}) async {
    if (query == "") {return;}
    state = const AsyncLoading();

    // 1초 동안 대기 후 가장 마지막 값을 검색합니다.
    watingWord = query;
    if (_isWating) {return;}
    _isWating = true;
    await Future.delayed(Duration(seconds: 1));

    _nowPage = 0;
    final data =  await _productManager.requestSearchProduct(page: _nowPage, query: watingWord);
    state = AsyncValue.data(data);
    _isWating = false;
    watingWord = "";
  }
}