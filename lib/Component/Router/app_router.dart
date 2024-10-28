import 'package:auto_route/auto_route.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';

import '../../Presentation/Detail/DetailScreen.dart';
import '../../Presentation/Home/HomeScreen.dart';
import '../../Presentation/MainTabbar/MainTabbarScreen.dart';
import '../../Presentation/Review/ReviewScreen.dart';
import '../Model/ProductModel.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainTabbarRoute.page, initial: true, path: "/", children: [
      AutoRoute(page: HomeRoute.page, path: 'home'),
      AutoRoute(page: DetailRoute.page, path: 'detail'),
      AutoRoute(page: ReviewRoute.page, path: 'detail/reviews'),
    ]),
  ];
}