import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Component/CommonWidget/CommonText.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false;
  bool _isAnimation = false;
  late TextEditingController _textEditingController;
  final _tfNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {

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
                alignment: Alignment.topLeft,
                child: TextField(
                  focusNode: _tfNode,
                  controller: _textEditingController,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      hintText: "Search for products",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize:  20),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.5)),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 1.5)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 2.5),
                  ))
                ),
              ),
          ),
            SizedBox(height: _isSearching ? 0 : 25,),
            Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child:  ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return CommonText(text: "$index", fontSize: 15);
                      }
                  ),
                )
            )
          ],
        )
    );
  }
}
