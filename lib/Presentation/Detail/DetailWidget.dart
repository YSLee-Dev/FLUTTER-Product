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
  late final PageController _pageController;
  late double _screenWidth = MediaQuery.of(context).size.width;

  bool _imageWidgetLeftArrowisHideen = true;
  bool _imageWidgetRightArrowisHideen = false;
  int _nowPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _pageController.addListener (() {
      if ((_pageController.page ?? 0.1) % 1.0 == 0.0) {
        setState(() {
          _nowPage = _pageController.page!.toInt();
          _imageWidgetLeftArrowisHideen = _pageController.page == 0.0;
          _imageWidgetRightArrowisHideen = _pageController.offset >= _pageController.position.maxScrollExtent;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<DetailViewModel>();

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
                          controller: _pageController,
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
              SizedBox(height: 30,),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: Color(0xfffcffcc),),
                    width: 100,
                    height: 50,
                  ),
                  Text("${_provider.sendedDetailInfo.title}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis)
                ],
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${((_provider.sendedDetailInfo.price ?? 0.0) / ((100 - (_provider.sendedDetailInfo.discountPercentage ?? 0.0)) / 100)).toStringAsFixed(2)}",
                    style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 18),
                  ),
                  Row(
                    children: [
                      Text('${_provider.sendedDetailInfo.discountPercentage}%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.redAccent,)),
                      SizedBox(width: 10,),
                      Text('${_provider.sendedDetailInfo.price}\$ ' , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)
                    ],
                  )
                ],
              )
            ],
          )
      )
    );
  }
}

