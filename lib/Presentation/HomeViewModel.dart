import 'package:flutter/foundation.dart';
import 'package:flutter_product/Model/ProductModel.dart';
import 'package:provider/provider.dart';

class HomeViewModel with ChangeNotifier {
  bool nowListShowTapped = true;
  //List<ProductModel> nowProductModelList = [];
  List<String> temp = ["1", "2", "1", "2", "1", "2", "1", "2"];

  void nowTappedIsList(bool isList) {
    nowListShowTapped = isList;
    notifyListeners();
  }
}