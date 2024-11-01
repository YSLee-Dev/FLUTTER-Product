import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Component/Model/ProductModel.dart';
part 'ReviewViewModel.g.dart';


@riverpod
class ReviewViewModel extends _$ReviewViewModel {
  List<ProductReviewModel> _sendedReview = [ProductReviewModel(comment: "", name: "", date: "1234567890")]; // 임시 값

  @override
  List<ProductReviewModel> build() {
    return _sendedReview;
  }

  void updateReviewModelList(List<ProductReviewModel> list) {
    _sendedReview = list;
    ref.invalidateSelf();
  }
}