import 'package:flutter/material.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_product/Presentation/Home/HomeViewModel.dart';
import '../Presentation/Home/HomeWidget.dart';
import '../Presentation/Detail/DetailWidget.dart';
import '../Presentation/Detail/DetailViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final routes = {
    HomeWidget.homeWidgetRouteName: (context) => ChangeNotifierProvider(
        create: (context) => HomeViewModel(),
        child: HomeWidget()
    ),

    DetailWidget.detailWidgetRoutename: (context) {
      return Builder(
        builder: (context) => Builder(
          builder: (context) {
            final model = ModalRoute.of(context)!.settings.arguments as ProductModel;
            return ChangeNotifierProvider(
              create: (context) => DetailViewModel(model: model),
              child: DetailWidget(),
            );
          },
        )
      );
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
      home: ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
          child: HomeWidget()
      ),
    );
  }
}
