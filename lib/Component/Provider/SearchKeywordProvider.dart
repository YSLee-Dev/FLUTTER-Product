import 'dart:ffi';

import 'package:flutter_product/Component/Dependency/SearchKeywordManager/ISearchKeywordManager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../Dependency/SearchKeywordManager/SearchKeywordManager.dart';
part 'SearchKeywordProvider.g.dart';

@riverpod
class SearchKeywordProvider extends _$SearchKeywordProvider {
  late ISearchKeywordManager _manager;

  @override
  Future<List<String>> build() async  {
    _manager = await SearchKeywordManager.getInstance();
    return await _manager.nowSaveKeywordRequest();
  }

   void removeKeyword({required String keyword}) {
    state.value!.remove(keyword);
    _manager.saveKeyword(keywords: state.value!);
  }

  void addKeyword({required String keyword})   {
    List<String> updatedList = [...state.value!];
    updatedList.add(keyword);
    state = AsyncData(updatedList);
    _manager.saveKeyword(keywords: state.value!);
  }
}