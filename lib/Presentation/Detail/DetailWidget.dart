import 'package:flutter/material.dart';
import 'package:flutter_product/Presentation/Detail/DetailViewModel.dart';
import 'package:provider/provider.dart';

class DetailWidget extends StatefulWidget {
  const DetailWidget({super.key});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data"),),
    );
  }
}
