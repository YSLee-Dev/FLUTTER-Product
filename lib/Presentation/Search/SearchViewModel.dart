import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Component/Dependency/ProductManager//IProductManager.dart';
import '../../Component/Dependency/ProductManager/ProductManager.dart';
import '../../Component/Model/ProductModel.dart';
part 'SearchViewModel.g.dart';

@riverpod
class SearchViewModel extends _$SearchViewModel {
  int _nowPage = 0;
  bool _isWating = false;
  String _watingWord = "";
  bool _isEnd = false;
  bool isRecommend = true;

  final IProductManager _productManager;

  SearchViewModel({IProductManager? productManager})
      : _productManager = productManager ?? ProductManager();

  @override
  Future<List<ProductModel>> build() async {
    return <ProductModel>[];
  }

  void querySearch({required String query}) async {
    _watingWord = query;

    if (_isWating) {return;}
    _isWating = true;
    _isEnd = false;
    state = const AsyncData([]);
    state = const AsyncLoading();

    // 1초 동안 대기 후 가장 마지막 값을 검색합니다.
    await Future.delayed(Duration(seconds: 1));

    _nowPage = 0;
    final nowSearchWord = _watingWord;
    state =  AsyncValue.data(await _requestProductSearch(query: nowSearchWord));

    // 검색 도중에 입력된 값이 있을 경우 다시 로딩해요.
    if (nowSearchWord != _watingWord) {
      querySearch(query: _watingWord);
    }
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
    isRecommend = query == "";
    print("${_nowPage}, ${query} ");
    return data;
  }
}