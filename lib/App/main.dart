import 'package:flutter/material.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_product/Presentation/Home/HomeViewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Presentation/Home/HomeWidget.dart';
import '../Presentation/Detail/DetailWidget.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final routes = {
    HomeWidget.homeWidgetRouteName: (context) => HomeWidget(),

    DetailWidget.detailWidgetRoutename: (context) {
      final model = ModalRoute.of(context)!.settings.arguments as ProductModel;
      //print(model.stock);
      return DetailWidget(sendedProductModel: model);
    }
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: routes,
      home: HomeWidget(),
    );
  }
}
