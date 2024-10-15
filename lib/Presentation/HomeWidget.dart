import 'package:flutter/material.dart';
import 'package:flutter_product/Presentation/HomeViewModel.dart';
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
    _scrollController.addListener (() {
      if ((_scrollController.position.maxScrollExtent - 100 < _scrollController.offset) && !_provider.nowLoading) {
        _provider.moreProductListRequet();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text("Home"),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: provider.nowListShowTapped
                                ? Colors.black
                                : Colors.black26),
                        onPressed: () {
                          provider.nowTappedIsList(true);
                        },
                        child: Text(
                          "리스트 보기",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: !provider.nowListShowTapped
                                ? Colors.black
                                : Colors.black26),
                        onPressed: () {
                          provider.nowTappedIsList(false);
                        },
                        child: Text(
                          "격자 보기",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 30),
              if (provider.nowProductModelList.isEmpty)
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
                        end: Offset(0.0, 0.0),
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: provider.nowListShowTapped
                      ? ListView.builder(
                      key: ValueKey<bool>(true),
                      controller: _scrollController,
                      itemCount: provider.nowProductModelList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      border: Border.all(color: Colors.black38, width: 1)),
                                  child: Image.network(
                                      '${provider.nowProductModelList[index].thumbnail}',
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return SizedBox(
                                              width: 120,
                                              height: 120,
                                              child: child);
                                        }
                                        return SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: CircularProgressIndicator(),
                                        );
                                      }),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${provider.nowProductModelList[index].title}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${provider.nowProductModelList[index].price}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              '${provider.nowProductModelList[index].tags?.first ?? ""}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                )
                              ],
                            )
                        );
                      }
                  )
                      : GridView.builder(
                      key: ValueKey<bool>(false),
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10
                      ),
                      itemCount: provider.nowProductModelList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              border: Border.all(color: Colors.black38, width: 1)),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.network(
                                  '${provider.nowProductModelList[index].thumbnail}',
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return CircularProgressIndicator();
                                  }),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.black45,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15)
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${provider.nowProductModelList[index].title}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
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
                                              '${provider.nowProductModelList[index].price}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Flexible(
                                          child: Text(
                                            '${provider.nowProductModelList[index].tags?.first ?? ""}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}