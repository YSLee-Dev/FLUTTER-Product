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
          SizedBox(height: 5),
          Row(
            children: [
              GestureDetector(
                  onTap: () => _viewCategoryBtnTapped(isList: true),
                  child: Container(
                    width: 50,
                    height: 50,
                    child:  Icon(Icons.list, color: !_nowListShowTapped ? Colors.black38 : Colors.black)
                  )
              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () => _viewCategoryBtnTapped(isList: false),
                child: Container(
                  width: 50,
                  height: 50,
                  child:  Icon(Icons.grid_3x3, color: _nowListShowTapped ? Colors.black38 : Colors.black) ,
                )
              ),
            ],
          ),
          Container(
            height: 5,
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
          ),
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
                  childAspectRatio: 1/1.3,
                ),
                itemCount: _provider.value!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _router.push(DetailRoute(sendedProductModel:  _provider.value![index],)),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            child:   Container(
                              color: Colors.black12.withOpacity(0.025),
                              child: Image.network(
                                '${_provider.value![index].thumbnail}',
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                            ),
                          ),
                          CommonText(text: '${_provider.value![index].title}', fontSize: 16, fontWeight: FontWeight.bold,),
                          SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: CommonText(text: '${_provider.value![index].price}', fontSize: 13, fontWeight: FontWeight.bold, textAlign: TextAlign.right)
                              ),
                              SizedBox(width: 5),
                              Flexible(
                                  child: CommonText(text:'${_provider.value![index].tags?.first ?? ""}', fontSize: 14)
                              ),
                            ],
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
