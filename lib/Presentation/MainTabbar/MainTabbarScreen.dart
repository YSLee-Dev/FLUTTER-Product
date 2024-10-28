import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product/Component/CommonWidget/CommonMainWidget.dart';

@RoutePage()
class MainTabbarScreen extends StatefulWidget {
  const MainTabbarScreen({super.key});

  @override
  State<MainTabbarScreen> createState() => MainTabbarScreenState();
}

class MainTabbarScreenState extends State<MainTabbarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search")
          ]
      ),
    );
  }
}
