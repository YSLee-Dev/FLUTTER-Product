import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Component/CommonWidget/CommonText.dart';
import 'package:flutter_product/Component/Provider/SearchKeywordProvider.dart';
import 'package:flutter_product/Component/Router/app_router.dart';
import 'package:flutter_product/Presentation/Search/SearchViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Component/CommonWidget/CommonProductWidget.dart';

@RoutePage()
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  bool _isSearching = false;
  bool _isAnimation = false;
  final _tfNode = FocusNode();

  late TextEditingController _textEditingController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _textEditingController = TextEditingController();
      _textEditingController.addListener(() async {
        ref.read(searchViewModelProvider.notifier).querySearch(query:  _textEditingController.text);
      });

      _scrollController = ScrollController();
      _scrollController.addListener((){
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 100 && !ref.read(searchViewModelProvider).isLoading) {
          ref.read(searchViewModelProvider.notifier).morePageRequest();
        }
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tfNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final  _size = MediaQuery.of(context).size;
    final providerValue = ref.watch(searchViewModelProvider);
    final router = AutoRouter.of(context);
    final searchKeywordProvider = ref.watch(searchKeywordProviderProvider);

    return CommonMainWidget(
        title: _isSearching ? "" : "Search",
        isBackIconShow: _isSearching ,
        action: () {
          setState(() {
            _textEditingController.text = "";
            _isSearching = false;
          });
        },
        widget: Column(
          children: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeInOutCirc,
              switchOutCurve: Curves.easeInOutCirc,
              transitionBuilder: (widget, animation) {
                animation.addListener(() {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if(!mounted) {return;}
                    setState(() {
                      if (animation.isCompleted) {
                        _isAnimation = false;
                      }
                    });
                  });
                });
                return SlideTransition(
                    position: Tween<Offset>(begin:  Offset(0.0, -0.4), end: Offset.zero).animate(animation),
                    child: AnimatedSize(
                        duration: const  Duration(milliseconds: 400),
                        curve: Curves.easeInOutCirc,
                        child:  SizedBox(
                          width: _isSearching ?_size.width : _size.width - 80,
                          child: FadeTransition(opacity: animation, child: widget,),
                        ),
                    )
                );
              },
              child: !_isSearching ?  GestureDetector(
                onTap: () {
                  setState(() {
                    _isSearching = !_isSearching;
                    _isAnimation = true;

                    if (_isSearching) {
                      Future.delayed(Duration(milliseconds: 300), () {
                        FocusScope.of(context).requestFocus(_tfNode);
                      });
                    }
                  });
                },
                child:  Container(
                    key: const ValueKey<bool>(true),
                    padding: EdgeInsets.only(top: 50),
                    alignment: Alignment.bottomLeft,
                    height: 100,
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 1.5))),
                    child:  CommonText(text: "Search for products", fontSize: 20, fontWeight: FontWeight.bold,)
                ),
              ) : Container(
                key: const ValueKey<bool>(false),
                padding: const EdgeInsets.only(bottom: 50),
                height: 100,
                alignment: Alignment.bottomLeft,
                child: TextField(
                  onSubmitted: (String value) {
                    FocusScope.of(context).unfocus();
                    ref.read(searchKeywordProviderProvider.notifier).addKeyword(keyword: value);
                  },
                  focusNode: _tfNode,
                  controller: _textEditingController,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      hintText: "Search for products",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize:  20, color: Colors.black45),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.5)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.5)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.5),
                  ))
                ),
              ),
          ),
           SizedBox(height: _isSearching ? 0 : 25,),
          if(searchKeywordProvider.value != null && !_isSearching && !_isAnimation)
          Flexible(
            child: ListView.builder(
                itemCount: searchKeywordProvider.value!.length,
                itemBuilder: (context, index) {
                  return  Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 7.5, bottom: 7.5),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isSearching = true;
                                  _textEditingController.text = searchKeywordProvider.value![index];
                                });
                              },
                              child:   CommonText(text: searchKeywordProvider.value![index], fontSize: 18, fontWeight: FontWeight.w500,),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              ref.read(searchKeywordProviderProvider.notifier).removeKeyword(keyword: searchKeywordProvider.value![index]);
                            },
                            child:  Icon(Icons.remove),
                          )
                        ],
                      )
                  );
                }
            )
          ),
          if(providerValue.isLoading && _isSearching && providerValue.value!.isEmpty)
            const SizedBox(
              width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor:  AlwaysStoppedAnimation<Color> (Colors.white), backgroundColor: Colors.black, strokeWidth: 2,)
              ,
            ),
          if(providerValue.value != null && _isSearching && providerValue.value!.isEmpty && !providerValue.isLoading && !ref.read(searchViewModelProvider.notifier).isRecommend)
           CommonText(text: "No search results", fontSize: 20, fontWeight: FontWeight.w500,),
           if(providerValue.value != null && _isSearching && providerValue.value!.isNotEmpty && ref.read(searchViewModelProvider.notifier).isRecommend && !_isAnimation)
           Container(
             width: _size.width,
             decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5))),
             padding: EdgeInsets.only(bottom: 10),
             child: CommonText(text: "Recommend Product", fontSize: 20, textAlign: TextAlign.left, fontWeight: FontWeight.bold,),
           ),
          if(providerValue.value != null && _isSearching && !_isAnimation)
            Flexible(
                child: Container(
                  padding: EdgeInsets.only(left: (_isSearching ? 0:  30), right: (_isSearching ? 0:  30)),
                  child:  ListView.builder(
                      controller: _scrollController,
                      itemCount: providerValue.value!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            router.push(DetailRoute(sendedProductModel: providerValue.value![index]));
                          },
                          child: ComminProductWidget(model: providerValue.value![index]),
                        );
                      }
                  ),
                )
            ),
            SizedBox(
              width: _size.width,
              height: 1,
            )
          ],
        )
    );
  }
}
