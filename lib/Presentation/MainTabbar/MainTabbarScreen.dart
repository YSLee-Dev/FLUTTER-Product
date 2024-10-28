import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';
import 'package:flutter_product/Component/Router/app_router.dart';

@RoutePage()
class MainTabbarScreen extends StatefulWidget {
  const MainTabbarScreen({super.key});

  @override
  State<MainTabbarScreen> createState() => MainTabbarScreenState();
}

class MainTabbarScreenState extends State<MainTabbarScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HomeRoute()
      ],
      bottomNavigationBuilder: (_, tabRouter) {
        return  BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: tabRouter.activeIndex,
            onTap: (index) {
              tabRouter.setActiveIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search")
            ]
        );
      }
    );
  }
}
