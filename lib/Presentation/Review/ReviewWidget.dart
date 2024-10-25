import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Component/CommonWidget/CommonText.dart';
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
        title: "Reviews",
        isBackIconShow: true,
        action: () {
          Navigator.pop(context);
        },
        widget: ListView.builder(
            itemCount: _provider.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Color(0xfffcffcc),)
                        ),
                        CommonText(text: "${_provider[index].name}", fontSize: 19, fontWeight: FontWeight.bold,)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), border: Border.all(color: Colors.black45, width: 1)),
                      child: Column(
                        children: [
                          CommonText(text: "${_provider[index].comment}", fontSize: 16, maxLine: 9999,),
                          SizedBox(height: 5,),
                          CommonText(text: "${_provider[index].date.substring(0, 10)}", fontSize: 14, fontColor: Colors.black54,),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
        ),
    );
  }
}