import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Component/Router/app_router.dart';
import 'package:flutter_product/Presentation/Detail/DetailScreen.dart';
import 'package:flutter_product/Presentation/Home/HomeViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Component/CommonWidget/CommonProductWidget.dart';
import '../../Component/CommonWidget/CommonText.dart';

@RoutePage()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late ScrollController _scrollController;
  bool _nowListShowTapped = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent - 100 < _scrollController.offset && !ref.read(homeViewModelProvider).isLoading) {
        ref.read(homeViewModelProvider.notifier).addProductList();
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
    setState(() {
     _nowListShowTapped = isList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _provider = ref.watch(homeViewModelProvider);
    final _router = AutoRouter.of(context);

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
                    backgroundColor: _nowListShowTapped ? Colors.black : Colors.black26,
                  ),
                  onPressed: () => _viewCategoryBtnTapped(isList: true),
                  child: CommonText(text: "List", fontSize: 15, fontColor: Colors.white,)
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_nowListShowTapped ? Colors.black : Colors.black26,
                  ),
                  onPressed: () => _viewCategoryBtnTapped(isList: false),
                    child: CommonText(text: "Grid", fontSize: 15, fontColor: Colors.white,)
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          if (_provider.value?.isEmpty ?? true)
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
          if (!(_provider.value?.isEmpty ?? true))
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(_nowListShowTapped? 0.2 : -0.2, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: _nowListShowTapped
                  ? ListView.builder(
                key: ValueKey<bool>(true),
                controller: _scrollController,
                itemCount: _provider.value!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _router.push(DetailRoute(sendedProductModel:  _provider.value![index],)),
                    child: ComminProductWidget(model: _provider.value![index])
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
                itemCount: _provider.value!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _router.push(DetailRoute(sendedProductModel:  _provider.value![index],)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black38, width: 1),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.network(
                            '${_provider.value![index].thumbnail}',
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
                                CommonText(text: '${_provider.value![index].title}', fontSize: 17, fontWeight: FontWeight.bold, fontColor: Colors.white,),
                                SizedBox(width: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: CommonText(text: '${_provider.value![index].price}', fontSize: 15, fontWeight: FontWeight.bold, fontColor: Colors.white, textAlign: TextAlign.right)
                                    ),
                                    SizedBox(width: 5),
                                    Flexible(
                                      child: CommonText(text:'${_provider.value![index].tags?.first ?? ""}', fontSize: 15, fontColor: Colors.white)
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
