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
  bool imageWidgetLeftArrowisHideen = true;
  bool imageWidgetRightArrowisHideen = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _pageController.addListener (() {
      if ((_pageController.page ?? 0.1) % 1.0 == 0.0) {
        setState(() {
          imageWidgetLeftArrowisHideen = _pageController.page == 0.0;
          imageWidgetRightArrowisHideen = _pageController.offset >= _pageController.position.maxScrollExtent;
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
          widget: Expanded(child: ListView(
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
                            double screenWidth = MediaQuery.of(context).size.width;
                            return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                      _provider.sendedDetailInfo.images![index], width: screenWidth, height: 200,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if(loadingProgress == null) {return child;}
                                        return CircularProgressIndicator();
                                      }
                                  ),
                                ]
                            );
                          }
                      ),
                      if (!imageWidgetLeftArrowisHideen)
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("◀", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black87),),
                        ),
                      if (!imageWidgetRightArrowisHideen)
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text("▶", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.black87)),
                        )
                    ],
                  )
              )
            ],
          )
          )
      )
    );
  }
}

