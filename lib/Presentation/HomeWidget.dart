import 'package:flutter/material.dart';
import 'package:flutter_product/Presentation/HomeViewModel.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static const homeWidgetRouteName = "homeWidgetRouteName";

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeViewModel>();


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text("Home"),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: provider.nowListShowTapped ? Colors.black : Colors.black26
                        ),
                        onPressed: () {
                          provider.nowTappedIsList(true);
                        },
                        child: Text("리스트 보기", style: TextStyle(color: Colors.white),)),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: !provider.nowListShowTapped ? Colors.black : Colors.black26
                        ),
                        onPressed: () {
                          provider.nowTappedIsList(false);
                        },
                        child: Text("격자 보기", style: TextStyle(color: Colors.white),)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              if(provider.nowListShowTapped)
              Expanded(
                child: ListView.builder(
                    itemCount: provider.temp.length,
                    itemBuilder: (context, int) {
                      return Text("${int}");
                    }),
              ),
              if(!provider.nowListShowTapped)
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: provider.temp.length,
                      itemBuilder: (context, int) {
                        return Text("${int}");
                      }),
                ),
            ],
          ),
        ));
  }
}
