import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Presentation/Detail/DetailWidget.dart';
import 'package:flutter_product/Presentation/Home/HomeViewModel.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static const homeWidgetRouteName = "homeWidgetRouteName";

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late ScrollController _scrollController;
  late final _provider = context.read<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent - 100 < _scrollController.offset && !_provider.nowLoading) {
        _provider.moreProductListRequet();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _viewCategoryBtnTapped({required bool isList}) {
    _scrollController.jumpTo(0);
    _provider.nowTappedIsList(isList);
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<HomeViewModel>();

    return CommonMainWidget(
      title: "Home",
      isBackIconShow: false,
      widget: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _provider.nowListShowTapped ? Colors.black : Colors.black26,
                  ),
                  onPressed: () => _viewCategoryBtnTapped(isList: true),
                  child: Text("List", style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_provider.nowListShowTapped ? Colors.black : Colors.black26,
                  ),
                  onPressed: () => _viewCategoryBtnTapped(isList: false),
                  child: Text("Grid", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          if (_provider.nowProductModelList.isEmpty)
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(_provider.nowListShowTapped ? 0.2 : -0.2, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: _provider.nowListShowTapped
                  ? ListView.builder(
                key: ValueKey<bool>(true),
                controller: _scrollController,
                itemCount: _provider.nowProductModelList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      DetailWidget.detailWidgetRoutename,
                      arguments: _provider.nowProductModelList[index],
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black38, width: 1),
                            ),
                            child: Image.network(
                              '${_provider.nowProductModelList[index].thumbnail}',
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return SizedBox(width: 120, height: 120, child: child);
                                }
                                return SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_provider.nowProductModelList[index].title}',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${_provider.nowProductModelList[index].price}',
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '${_provider.nowProductModelList[index].tags?.first ?? ""}',
                                      style: TextStyle(fontSize: 15),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : GridView.builder(
                key: ValueKey<bool>(false),
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: _provider.nowProductModelList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      DetailWidget.detailWidgetRoutename,
                      arguments: _provider.nowProductModelList[index],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black38, width: 1),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.network(
                            '${_provider.nowProductModelList[index].thumbnail}',
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return CircularProgressIndicator();
                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${_provider.nowProductModelList[index].title}',
                                  style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(width: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        '${_provider.nowProductModelList[index].price}',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      child: Text(
                                        '${_provider.nowProductModelList[index].tags?.first ?? ""}',
                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
