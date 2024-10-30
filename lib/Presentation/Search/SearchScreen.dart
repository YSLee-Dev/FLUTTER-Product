import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Component/CommonWidget/CommonText.dart';
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

    return CommonMainWidget(
        title: _isAnimation ? "" : (_isSearching ? "" : "Search" ),
        isBackIconShow: _isAnimation ? false : _isSearching,
        action: () {
          setState(() {
            _isSearching = false;
          });
        },
        widget: Column(
          children: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (widget, animation) {
                animation.addListener(() {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if(mounted) {
                      setState(() {
                        if (_isAnimation != (!animation.isCompleted)) {
                          _isAnimation = !animation.isCompleted;
                        }
                      });
                    }
                  });
                });
                return SlideTransition(
                    position: Tween<Offset>(begin:  Offset(0.0, -0.7), end: Offset.zero).animate(animation),
                    child: AnimatedSize(
                        duration: const  Duration(milliseconds: 250),
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
          if(providerValue.isLoading && _isSearching && providerValue.value!.isEmpty)
            const SizedBox(
              width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor:  AlwaysStoppedAnimation<Color> (Colors.white), backgroundColor: Colors.black, strokeWidth: 2,)
              ,
            ),
          if(providerValue.value != null && _isSearching)
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
