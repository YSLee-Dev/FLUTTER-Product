import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

import '../../Presentation/Detail/DetailScreen.dart';
import '../../Presentation/Home/HomeScreen.dart';
import '../../Presentation/Review/ReviewScreen.dart';
import '../Model/ProductModel.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: DetailRoute.page),
    AutoRoute(page: ReviewRoute.page),
  ];
}