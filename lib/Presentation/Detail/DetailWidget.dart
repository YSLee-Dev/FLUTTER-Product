import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Component/CommonWidget/CommonText.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_product/Presentation/Detail/DetailViewModel.dart';
import 'package:flutter_product/Presentation/Review/ReviewWidget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailWidget extends ConsumerStatefulWidget {
  static const String detailWidgetRoutename = "detailWidgetRoutename";
  final ProductModel sendedProductModel;
  const DetailWidget({super.key, required this.sendedProductModel});

  @override
  ConsumerState<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends ConsumerState<DetailWidget> {
  late final PageController _imagePageController;
  late final PageController _reviewsPageController;
  late double _screenWidth = MediaQuery.of(context).size.width;

  bool _imageWidgetLeftArrowisHideen = true;
  bool _imageWidgetRightArrowisHideen = false;
  bool userScrolled = false;
  int _nowPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       // Widget으로 전달된 model을 ViewModel(Provider)에 전달하여 초기화
      ref.read(detailViewModelProvider.notifier)
          .updateModel(widget.sendedProductModel);
    });

    _imagePageController = PageController();
    _imagePageController.addListener (() {
      if ((_imagePageController.page ?? 0.1) % 1.0 == 0.0) {
        setState(() {
          _nowPage = _imagePageController.page!.toInt();
          _imageWidgetLeftArrowisHideen = _imagePageController.page == 0.0;
          _imageWidgetRightArrowisHideen = _imagePageController.offset >= _imagePageController.position.maxScrollExtent;
        });
      }
    });
    _reviewsPageController = PageController();
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _reviewsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = ref.watch(detailViewModelProvider);

    ref.listen<AsyncValue<int>>(
      reviewIndexTimerProvider(
          reviewsLength: ref.watch(detailViewModelProvider).reviews?.length ?? 0
      ),(_, next) {
        next.whenData((index) {
          _reviewsPageController.animateTo(
              index * 55,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutCirc
          );
        });
      },
    );

    return CommonMainWidget(
      title: "Detail Product",
      isBackIconShow: true,
      action: () {
        Navigator.pop(context);
      },
      widget: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView(
            children: [
              SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _provider.images?.length ?? 0,
                          controller: _imagePageController,
                          itemBuilder: (context, index) {
                            return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                      _provider.images![index], width: _screenWidth, height: 200,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if(loadingProgress == null) {return child;}
                                        return CircularProgressIndicator();
                                      }
                                  ),
                                ]
                            );
                          }
                      ),
                      if (!_imageWidgetLeftArrowisHideen)
                        Container(
                            alignment: Alignment.centerLeft,
                            child: CommonText(text: "◀", fontSize: 25, fontWeight: FontWeight.w600, fontColor: Colors.black87)
                        ),
                      if (!_imageWidgetRightArrowisHideen && (_provider.images?.length ?? 0) >= 2)
                        Container(
                            alignment: Alignment.centerRight,
                            child: CommonText(text: "▶", fontSize: 25, fontWeight: FontWeight.w600, fontColor: Colors.black87)
                        )
                    ],
                  )
              ),
              SizedBox(height: 5,),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.black12),
                    width: _screenWidth,
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.black87),
                    width: _screenWidth - (_screenWidth / max(((_provider.images?.length ?? 1) - 1), 1) * max((((_provider.images?.length ?? 1) - 1) - _nowPage), 0)),
                    height: 20,
                  )
                ],
              ),
              SizedBox(height: 20,),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Color(0xfffcffcc),),
                    width: 100,
                    height: 50,
                  ),
                  CommonText(text: "${_provider.title}", fontSize: 21, fontWeight: FontWeight.bold, maxLine: 2,)
                ],
              ),
              CommonText(text: '${_provider.brand ?? 'Depends on destination'}', fontSize: 16,),
              SizedBox(height: 20,),
              Container(
                height: 30,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _provider.tags?.length ?? 0,
                    itemBuilder: (builder, index) {
                      return Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.black45),
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: CommonText(text: "${_provider.tags![index]}", fontSize: 14, fontColor: Colors.white)
                          ),
                          SizedBox(width: 10,)
                        ],
                      );
                    }
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${((_provider.price ?? 0.0) / ((100 - (_provider.discountPercentage ?? 0.0)) / 100)).toStringAsFixed(2)}\$",
                    style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 17),
                  ),
                  Row(
                    children: [
                      CommonText(text: '${_provider.discountPercentage}%', fontSize: 23, fontWeight: FontWeight.bold, fontColor: Colors.redAccent,),
                      SizedBox(width: 10,),
                      CommonText(text: '${_provider.price}\$ ', fontSize: 23, fontWeight: FontWeight.bold,)
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ReviewWidget.reviewWidgetRoutename, arguments: _provider.reviews);
                },
                child: CommonText(text: "Reviews →", fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5,),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), border: Border.all(color: Colors.black45, width: 1)),
                  height: 60,
                  child: PageView.builder(
                      controller: _reviewsPageController,
                      scrollDirection: Axis.vertical,
                      itemCount: _provider.reviews?.length ?? 0,
                      onPageChanged: (index) {

                      },
                      itemBuilder: (context, index) {
                        return Container(
                          width: _screenWidth,
                          padding: EdgeInsets.only(left: 15, right: 15),
                          height: 60,
                          child: Row(
                            children: [
                              CommonText(text: '🧑🏻 ', fontSize: 23),
                              CommonText(text: '${_provider.reviews![index].name}', fontSize: 15),
                              SizedBox(width: 10),
                              Flexible(child: CommonText(text: '${_provider.reviews![index].comment}', fontSize: 15, fontWeight: FontWeight.w600,))
                            ],
                          ),
                        );
                      }
                  )
              ),
              SizedBox(height: 20,),
              CommonText(text: "Product description", fontSize: 21, fontWeight: FontWeight.bold),
              SizedBox(height: 5,),
              Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), border: Border.all(color: Colors.black45, width: 1)),
                  child: CommonText(text: "${_provider.description}", fontSize: 15, maxLine: 10000)
              ),
              SizedBox(height: 100,) // 여백
            ],
          ),
          Container(
              width: _screenWidth,
              height: 90,
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  CommonText(text: "Store: ${_provider.stock}", fontSize: 15, fontWeight: FontWeight.bold,),
                  SizedBox(height: 10,),
                  Expanded(child: Container(
                    width: _screenWidth,
                    child: ElevatedButton(
                        style:  ElevatedButton.styleFrom(backgroundColor: _provider.stock <= 0 ? Colors.black38 :Colors.black),
                        onPressed: () async {
                          if (_provider.stock <= 0) {return null;}
                          final sheetValue = showModalBottomSheet(
                            context: context,
                            builder: (context) {
                             return Consumer(
                               builder: (context, ref, _) {
                                 final _orderQuantity = ref.watch(orderQuantityProvider);
                                 return CommonMainWidget(
                                   isInScaffold: false ,
                                   title: 'Add to Cart',
                                   isBackIconShow: false,
                                   backgroundColor: Colors.white,
                                   borderRadius: BorderRadius.circular(15),
                                   widget: Column(
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       SizedBox(height: 10,),
                                       Container(
                                         decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(15)),
                                         padding: EdgeInsets.all(15),
                                         child: Column(
                                           mainAxisSize: MainAxisSize.min,
                                           children: [
                                             CommonText(text: "${_provider.title}", fontSize: 18, fontWeight: FontWeight.bold),
                                             SizedBox(height: 15,),
                                             Row(
                                               children: [
                                                 ElevatedButton(
                                                     style:  ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                                     onPressed: () {
                                                       if (_orderQuantity <= 1) {return;}
                                                       ref.read(orderQuantityProvider.notifier).update((state) => state - 1);
                                                     },
                                                     child: CommonText(text: "-", fontSize: 18, fontWeight: FontWeight.bold, fontColor: Colors.white,)
                                                 ),
                                                 SizedBox(width: 15,),
                                                 CommonText(text: "${_orderQuantity}", fontSize: 20, fontWeight: FontWeight.bold,),
                                                 SizedBox(width: 15,),
                                                 ElevatedButton(
                                                     style:  ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                     onPressed: () {
                                                       if (_orderQuantity >= _provider.stock) {return;}
                                                       ref.read(orderQuantityProvider.notifier).state += 1;
                                                     },
                                                     child: CommonText(text: "+", fontSize: 18, fontWeight: FontWeight.bold)
                                                 ),
                                                 Expanded(child: CommonText(text: "${(_provider.price! * _orderQuantity).toStringAsFixed(2)}\$", fontSize: 18, fontWeight: FontWeight.bold, textAlign: TextAlign.right,),)
                                               ],
                                             )
                                           ],
                                         ),
                                       ),
                                       SizedBox(height: 20,),
                                       Container(
                                         width: _screenWidth,
                                         height: 50,
                                         child: ElevatedButton(
                                             style:  ElevatedButton.styleFrom(backgroundColor: Colors.black),
                                             onPressed: () {
                                               Navigator.pop(context, _orderQuantity);
                                             },
                                             child: CommonText(text: "Add to Cart", fontSize: 18, fontWeight: FontWeight.bold, fontColor: Colors.white)
                                         ),
                                       ),
                                       SizedBox(height: 30,),
                                     ],
                                   ),
                                 );
                               }
                             );
                            }
                          );
                          final addCartQuantity = await sheetValue;
                          if (addCartQuantity != null) {
                            ref.read(detailViewModelProvider.notifier).updateModel(_provider.copyWith(stock: _provider.stock - addCartQuantity as int));

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("Added ${addCartQuantity! as int} items to your cart"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  duration: Duration(milliseconds: 2000),
                              )
                            );
                          }
                        },
                        child: CommonText(text: "Add to Cart", fontSize: 18, fontWeight: FontWeight.bold, fontColor: Colors.white)
                    ),
                  )
                  )
                ],
              )
          ),
        ],
      ),
    );
  }
}

