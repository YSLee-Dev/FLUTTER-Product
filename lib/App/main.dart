import 'package:flutter/material.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_product/Component/Router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Presentation/Home/HomeScreen.dart';
import '../Presentation/Detail/DetailScreen.dart';
import '../Presentation/Review/ReviewScreen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Product',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter.config()
    );
  }
}
