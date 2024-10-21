import 'package:flutter/material.dart';

class CommonMainWidget extends StatelessWidget {
  final bool _isInScaffold;
  final Widget _widget;
  final String _title;
  final bool _isBackIconShow;
  final Color _backGroundColor;
  final BorderRadius _borderRadius;
  final Function()? _titleTappedAction;

  CommonMainWidget({bool isInScaffold = true, required String title, required bool isBackIconShow, Color backgroundColor = Colors.white, BorderRadius borderRadius = BorderRadius.zero, Function()? action, required Widget widget})
      : _isInScaffold = isInScaffold,  _widget = widget, _title = title, _isBackIconShow = isBackIconShow, _backGroundColor = backgroundColor, _borderRadius = borderRadius, _titleTappedAction = action;

  Widget _createWidget() {
   return Container(
     decoration: BoxDecoration(borderRadius: _borderRadius, color: _backGroundColor),
     padding: EdgeInsets.only(left: 20, right: 20, top: 10),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         GestureDetector(
           onTap: () {
             if (_titleTappedAction != null) {
               _titleTappedAction!();
             }
           },
           child: Text("${_isBackIconShow ? "← " : ""}${_title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
         ),
         Expanded(child: _widget)
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
        )
        : _createWidget();
  }
}
