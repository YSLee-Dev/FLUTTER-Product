import 'package:flutter/foundation.dart';
import 'package:flutter_product/Dependency/IProductManager.dart';
import 'package:flutter_product/Dependency/ProductManager.dart';
import 'package:flutter_product/Model/ProductModel.dart';
import 'package:flutter_product/Network/INetworkManager.dart';
import 'package:provider/provider.dart';
import '../Network/NetworkManager.dart';

class HomeViewModel with ChangeNotifier {
  bool nowListShowTapped = true;
  int nowPage = 1;
  final IProductManager _productManager;

  List<ProductModel> nowProductModelList = [];

  HomeViewModel({IProductManager? productManager})
   : _productManager = productManager ?? ProductManager() {
    requestProductList(1, 10);
  }

  void nowTappedIsList(bool isList) {
    nowListShowTapped = isList;
    notifyListeners();
  }

  void requestProductList(int page, int count) async {
    nowProductModelList = await _productManager.requestMainProduct(1, 10);
    notifyListeners();
  }
}