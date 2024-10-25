import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Component/Model/ProductModel.dart';
part 'ReviewViewModel.g.dart';


@riverpod
class ReviewViewModel extends _$ReviewViewModel {
  List<ProductReviewModel> _sendedReview = [];

  @override
  List<ProductReviewModel> build() {
    return _sendedReview;
  }

  void updateReviewModelList(List<ProductReviewModel> list) {
    _sendedReview = list;
    ref.invalidateSelf();
  }
}