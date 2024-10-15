import 'package:flutter/foundation.dart';
import 'package:flutter_product/Dependency/IProductManager.dart';
import 'package:flutter_product/Dependency/ProductManager.dart';
import 'package:flutter_product/Model/ProductModel.dart';
import 'package:flutter_product/Network/INetworkManager.dart';
import 'package:provider/provider.dart';
import '../Network/NetworkManager.dart';

class HomeViewModel with ChangeNotifier {
  bool nowListShowTapped = true;
  int nowPage = 0;
  bool nowLoading = false;
  final IProductManager _productManager;

  List<ProductModel> nowProductModelList = [];

  HomeViewModel({IProductManager? productManager})
   : _productManager = productManager ?? ProductManager() {
    _requestProductList();
  }

  void nowTappedIsList(bool isList) {
    nowListShowTapped = isList;
    notifyListeners();
  }

  void moreProductListRequet() {
    _requestProductList();
  }

  void _requestProductList({int count = 10}) async {
    nowPage ++;
    nowLoading = true;
    nowProductModelList += await _productManager.requestMainProduct(nowPage, count);

    notifyListeners();
    nowLoading = false;

    print("${nowPage} ${count}");
  }
}