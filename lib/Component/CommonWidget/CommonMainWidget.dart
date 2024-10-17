import 'package:flutter/material.dart';

class CommonMainWidget extends StatelessWidget {
  final Widget _widget;
  final String _title;
  final bool _isBackIconShow;
  final Function()? _titleTappedAction;

  CommonMainWidget({required String title, required bool isBackIconShow, Function()? action, required Widget widget})
      : _widget = widget, _title = title, _isBackIconShow = isBackIconShow, _titleTappedAction = action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_titleTappedAction != null) {
                      _titleTappedAction!();
                    }
                  },
                  child: Text("${_isBackIconShow ? "←" : ""} ${_title}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                ),
                _widget
              ],
            ),
          ),
        )
    );
  }
}
