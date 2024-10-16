import 'dart:convert';
import 'package:flutter_product/Model/ProductModel.dart';
import 'package:flutter_product/Network/INetworkManager.dart';
import 'package:flutter_product/Network/NetworkManager.dart';
import 'IProductManager.dart';

class ProductManager implements IProductManager {
  static final _shared = ProductManager._internal();
  INetworkManager? _networkManager;

  ProductManager._internal();

  factory ProductManager({INetworkManager? networkManager}) {
    if (_shared._networkManager == null) {
      _shared._networkManager = networkManager ?? NetworkManager();
    }
    return _shared;
  }

  @override
  Future<List<ProductModel>> requestMainProduct(int page, int count) async {
    Uri uri = Uri.https(
        'dummyjson.com', 'products', {"limit": "10", "skip": "${page * 10}"});
    final result =  await _networkManager!.requestData(
        decoder: (context) {
          final product = context["products"];
          final decondingData = (product as List).map ((v) {
            return ProductModel.fromJson(v);
          });
          return decondingData.toList();
        },
        urlString: uri.toString());

  return result;
  }


}
