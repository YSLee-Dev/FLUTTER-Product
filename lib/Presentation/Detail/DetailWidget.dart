import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Presentation/Detail/DetailViewModel.dart';
import 'package:provider/provider.dart';

class DetailWidget extends StatefulWidget {
  static const String detailWidgetRoutename = "detailWidgetRoutename";

  const DetailWidget({super.key});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  late final PageController _imagePageController;
  late final PageController _reviewsPageController;
  late double _screenWidth = MediaQuery.of(context).size.width;
  late final _provider = context.read<DetailViewModel>();
  late final StreamSubscription<int>? _indexStream;

  bool _imageWidgetLeftArrowisHideen = true;
  bool _imageWidgetRightArrowisHideen = false;
  int _nowPage = 0;

  @override
  void initState() {
    super.initState();
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
    _indexStream =_provider.reviewIndexTimer().listen((index) {
      _reviewsPageController.animateTo(index * 55, duration: Duration(milliseconds: 500), curve: Curves.easeInOutCirc);
    });
  }

  @override
  void dispose() {
    _imagePageController.dispose();
    _reviewsPageController.dispose();
    _indexStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CommonMainWidget(
          title: "Detail Product",
          isBackIconShow: true,
          action: () {
            Navigator.pop(context);
          },
          widget: ListView(
            children: [
              SizedBox(
                  height: 200,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _provider.sendedDetailInfo.images?.length ?? 0,
                          controller: _imagePageController,
                          itemBuilder: (context, index) {
                            return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                      _provider.sendedDetailInfo.images![index], width: _screenWidth, height: 200,
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
                          child: Text("◀", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black87),),
                        ),
                      if (!_imageWidgetRightArrowisHideen && (_provider.sendedDetailInfo.images?.length ?? 0) >= 2)
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("▶", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black87)),
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
                    width: _screenWidth - (_screenWidth / max(((_provider.sendedDetailInfo.images?.length ?? 1) - 1), 1) * max((((_provider.sendedDetailInfo.images?.length ?? 1) - 1) - _nowPage), 0)),
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
                  Text("${_provider.sendedDetailInfo.title}", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${_provider.sendedDetailInfo.brand ?? 'Depends on destination'}', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 15,),
                  Text("${((_provider.sendedDetailInfo.price ?? 0.0) / ((100 - (_provider.sendedDetailInfo.discountPercentage ?? 0.0)) / 100)).toStringAsFixed(2)}",
                    style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 17),
                  ),
                  Row(
                    children: [
                      Text('${_provider.sendedDetailInfo.discountPercentage}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.redAccent,)),
                      SizedBox(width: 10,),
                      Text('${_provider.sendedDetailInfo.price}\$ ' , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),)
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("Reviews →", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), border: Border.all(color: Colors.black45, width: 1)),
                height: 60,
                child: PageView.builder(
                    controller: _reviewsPageController,
                    scrollDirection: Axis.vertical,
                    itemCount: _provider.sendedDetailInfo.reviews?.length ?? 0,
                    onPageChanged: (index) {
                        _provider.nowShowingReviewIndexChnage(index);
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: _screenWidth,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 60,
                        child: Row(
                          children: [
                            Text('🧑🏻 ', style: TextStyle(fontSize: 20),),
                            Text('${_provider.sendedDetailInfo.reviews![index].name}', style: TextStyle(fontSize: 15),),
                            SizedBox(width: 10),
                            Text('${_provider.sendedDetailInfo.reviews![index].comment}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),)
                          ],
                        ),
                      );
                    }
                )
              )
            ],
          )
      )
    );
  }
}

