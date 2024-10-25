import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Presentation/Review/ReviewViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Component/Model/ProductModel.dart';

class ReviewWidget extends ConsumerStatefulWidget {
  final List<ProductReviewModel> sendedReviewModelList;
  static const String reviewWidgetRoutename = "reviewWidgetRoutename";

  const ReviewWidget({super.key, required this.sendedReviewModelList});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ReviewWidgetState();
}

class ReviewWidgetState extends ConsumerState<ReviewWidget> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reviewViewModelProvider.notifier)
          .updateReviewModelList(widget.sendedReviewModelList);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _provider = ref.watch(reviewViewModelProvider);

    return CommonMainWidget(
        title: "Review",
        isBackIconShow: true,
        action: () {
          Navigator.pop(context);
        },
        widget: Column(
          children: [
            Text('${_provider.first?.name ?? ""}')
          ],
        )
    );
  }
}