// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [DetailScreen]
class DetailRoute extends PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    Key? key,
    required ProductModel sendedProductModel,
    List<PageRouteInfo>? children,
  }) : super(
          DetailRoute.name,
          args: DetailRouteArgs(
            key: key,
            sendedProductModel: sendedProductModel,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DetailRouteArgs>();
      return DetailScreen(
        key: args.key,
        sendedProductModel: args.sendedProductModel,
      );
    },
  );
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.sendedProductModel,
  });

  final Key? key;

  final ProductModel sendedProductModel;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, sendedProductModel: $sendedProductModel}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [MainTabbarScreen]
class MainTabbarRoute extends PageRouteInfo<void> {
  const MainTabbarRoute({List<PageRouteInfo>? children})
      : super(
          MainTabbarRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainTabbarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainTabbarScreen();
    },
  );
}

/// generated route for
/// [ReviewScreen]
class ReviewRoute extends PageRouteInfo<ReviewRouteArgs> {
  ReviewRoute({
    Key? key,
    required List<ProductReviewModel> sendedReviewModelList,
    List<PageRouteInfo>? children,
  }) : super(
          ReviewRoute.name,
          args: ReviewRouteArgs(
            key: key,
            sendedReviewModelList: sendedReviewModelList,
          ),
          initialChildren: children,
        );

  static const String name = 'ReviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewRouteArgs>();
      return ReviewScreen(
        key: args.key,
        sendedReviewModelList: args.sendedReviewModelList,
      );
    },
  );
}

class ReviewRouteArgs {
  const ReviewRouteArgs({
    this.key,
    required this.sendedReviewModelList,
  });

  final Key? key;

  final List<ProductReviewModel> sendedReviewModelList;

  @override
  String toString() {
    return 'ReviewRouteArgs{key: $key, sendedReviewModelList: $sendedReviewModelList}';
  }
}
