import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  String _text;
  double _fontSize;
  FontWeight _fontWeight;
  Color _fontColor;
  int _maxLine;
  TextOverflow _overflow;

  CommonText({required String text, required double fontSize, FontWeight fontWeight = FontWeight.normal, Color fontColor = Colors.black, int maxLine = 1, TextOverflow overFlow = TextOverflow.ellipsis})
  : _text = text, _fontSize = fontSize, _fontWeight = fontWeight, _fontColor = fontColor, _maxLine = maxLine, _overflow = overFlow;


  @override
  Widget build(BuildContext context) {
    return Text('${_text}', style: TextStyle(fontWeight: _fontWeight, fontSize: _fontSize, color: _fontColor), maxLines: _maxLine, overflow: _overflow,);
  }
}