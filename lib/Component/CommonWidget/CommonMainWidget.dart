import 'package:flutter/material.dart';

class CommonMainWidget extends StatelessWidget {
  final bool _isInScaffold;
  final Widget _widget;
  final String _title;
  final bool _isBackIconShow;
  final Color _backGroundColor;
  final BorderRadius _borderRadius;
  final List<BottomNavigationBarItem>_navigationBarItem;
  final Function()? _titleTappedAction;

  CommonMainWidget({
    bool isInScaffold = true, required String title, required bool isBackIconShow,
    Color backgroundColor = Colors.white, BorderRadius borderRadius = BorderRadius.zero,
    List<BottomNavigationBarItem> navigationBarItem = const <BottomNavigationBarItem>[], Function()? action, required Widget widget
  })
      : _isInScaffold = isInScaffold,  _widget = widget, _title = title, _isBackIconShow = isBackIconShow,
        _backGroundColor = backgroundColor, _borderRadius = borderRadius, _navigationBarItem = navigationBarItem, _titleTappedAction = action;

  Widget _createWidget() {
   return Container(
     decoration: BoxDecoration(borderRadius: _borderRadius, color: _backGroundColor),
     padding: EdgeInsets.only(top: 10),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         GestureDetector(
           onTap: () {
             if (_titleTappedAction != null) {
               _titleTappedAction!();
             }
           },
           child: Container(
             padding: EdgeInsets.only(left: _isBackIconShow ? 10 : 20, right: 20),
             child:   Row(
               children: [
                 if(_isBackIconShow)
                  Icon(Icons.chevron_left_rounded, size: 35),
                 Text("${_title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
               ],
             ),
           )
         ),
         Flexible(child:
         Container(
           padding: EdgeInsets.only(left: 20, right: 20),
           child: _widget,
         )
         )
       ],
     ),
   );
  }

  @override
  Widget build(BuildContext context) {
    return _isInScaffold ?
        Scaffold(
          backgroundColor: _backGroundColor,
          body: SafeArea(child: _createWidget()
          ),
          bottomNavigationBar: _navigationBarItem.length >= 2 ?   BottomNavigationBar(
            items: _navigationBarItem,
            backgroundColor: Colors.white,
          ) : null,
        )
        : _createWidget();
  }
}
