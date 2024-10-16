import 'package:flutter/material.dart';
import 'package:flutter_product/Presentation/Detail/DetailViewModel.dart';
import 'package:provider/provider.dart';

class DetailWidget extends StatefulWidget {
  static const String detailWidgetRoutename = "detailWidgetRoutename";

  const DetailWidget({super.key});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<DetailViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text("${_provider.sendedDetailInfo.title}"),),
    );
  }
}
