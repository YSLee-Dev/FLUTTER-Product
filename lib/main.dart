import 'package:flutter/material.dart';
import 'package:flutter_product/Presentation/HomeViewModel.dart';
import 'Presentation/HomeWidget.dart';
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
    )
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
