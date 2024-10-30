import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Component/Dependency/IProductManager.dart';
import '../../Component/Dependency/ProductManager.dart';
import '../../Component/Model/ProductModel.dart';
part 'SearchViewModel.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  int _nowPage = 0;
  bool _isWating = false;
  String _watingWord = "";
  bool _isEnd = false;
  final IProductManager _productManager;

  SearchViewModel({IProductManager? productManager})
      : _productManager = productManager ?? ProductManager();

  @override
  Future<List<ProductModel>> build() async {
    return <ProductModel>[];
  }

  void querySearch({required String query}) async {
    if (query == "") {return;}

    // 1초 동안 대기 후 가장 마지막 값을 검색합니다.
    _watingWord = query;
    if (_isWating) {return;}
    _isWating = true;
    _isEnd = false;
    state = const AsyncData([]);
    state = const AsyncLoading();
    await Future.delayed(Duration(seconds: 1));

    _nowPage = 0;
    state =  AsyncValue.data(await _requestProductSearch(query: _watingWord));
  }

  void morePageRequest() async {
    if ( _isEnd) {return;}

    state = const AsyncLoading();
    final data = await _requestProductSearch(query: _watingWord);

    if (data.isEmpty) {
      _isEnd = true;
    } else {
      state = AsyncData(state.value! + data);
    }
  }

  Future<List<ProductModel>> _requestProductSearch({required String query}) async {
    final data =  await _productManager.requestSearchProduct(page: _nowPage, query: query);
    _isWating = false;
    _nowPage ++;
    print("${_nowPage}, ${query} ");
    return data;
  }
}