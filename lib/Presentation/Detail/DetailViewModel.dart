import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'DetailViewModel.g.dart';

@riverpod
Stream<int> reviewIndexTimer(ReviewIndexTimerRef ref,{required int reviewsLength}) async* {
  int _reviewShowingIndex = 0;
  if (reviewsLength < 2) {
    return;
  }
  while (true) {
    await Future.delayed(Duration(seconds: 2));
    if (_reviewShowingIndex >= reviewsLength -1 ) {
      _reviewShowingIndex = 0;
    } else {
      _reviewShowingIndex = ++_reviewShowingIndex;
    }

    //await Future.delayed(Duration(seconds: userScrolled ? 1 : 0));
    yield _reviewShowingIndex;
  }
}

StateProvider<int> orderQuantity(OrderQuantityRef ref) {
  return StateProvider((ref) => 0);
}

@riverpod
class DetailViewModel extends _$DetailViewModel {
  // 임의의 값
  ProductModel _sendedDetailInfo = ProductModel(id: 0, title: "title", description: "description", stock: 0);

  void updateModel(ProductModel model) {
    _sendedDetailInfo = model;
    ref.invalidateSelf();
  }

  ProductModel build() {
    return _sendedDetailInfo;
  }
}