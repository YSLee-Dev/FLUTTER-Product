import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';

class DetailViewModel with ChangeNotifier  {
  final ProductModel sendedDetailInfo;
  int get orderQuantity => _orderQuantity;

  int _reviewShowingIndex = 0;
  bool _userScrolled = false;
  int _orderQuantity = 1;

  DetailViewModel({required ProductModel model }) : sendedDetailInfo = model;

  void nowShowingReviewIndexChnage(int index) {
    _reviewShowingIndex = index;
    _userScrolled = true;
  }

  Stream<int> reviewIndexTimer() async* {
    if ((sendedDetailInfo.reviews?.length ?? 0) < 2) {
      return;
    }
    while (true) {
      await Future.delayed(Duration(seconds: 2));
      if (_reviewShowingIndex >= (sendedDetailInfo.reviews!.length) -1 ) {
        _reviewShowingIndex = 0;
      } else {
        _reviewShowingIndex = ++_reviewShowingIndex;
      }

      await Future.delayed(Duration(seconds: _userScrolled ? 1 : 0));
      _userScrolled = false;
      yield _reviewShowingIndex;
    }
  }

  void orderQuantityPlus() {
    if ((_orderQuantity + 1) > sendedDetailInfo.stock) {return;}
    _orderQuantity ++;
    notifyListeners();
  }

  void orderQuantityMinus() {
    if ((_orderQuantity - 1) < 0) {return;}
    _orderQuantity --;
    notifyListeners();
  }
}