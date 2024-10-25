import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewWidget extends ConsumerStatefulWidget {
  const ReviewWidget({super.key});
  static const String reviewWidgetRoutename = "reviewWidgetRoutename";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ReviewWidgetState();
}

class ReviewWidgetState extends ConsumerState<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return CommonMainWidget(
        title: "Review",
        isBackIconShow: true,
        widget: Column(

        )
    );
  }
}