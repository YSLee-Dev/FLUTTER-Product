import 'dart:convert';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_product/Component/Network/INetworkManager.dart';
import 'package:flutter_product/Component/Network/NetworkManager.dart';
import '../ProductManager//IProductManager.dart';

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
        'dummyjson.com', 'products',
        {"limit": "${count}", "skip": "${page * 10}"});
    final result = await _networkManager!.requestData(
        decoder: (context) {
          final product = context["products"];
          final decondingData = (product as List).map((v) {
            return ProductModel.fromJson(v);
          });
          return decondingData.toList();
        },
        urlString: uri.toString());

    return result;
  }

  @override
  Future<List<ProductModel>> requestSearchProduct({required int page, required String query, int count = 10}) async {
    Uri uri = Uri.https(
        'dummyjson.com', 'products/search',
        {"q": query, "limit": "${count}", "skip": "${page * 10}"}
    );
    final result = await _networkManager!.requestData(
        decoder: (context) {
          final product = context["products"];
          final decondingData = (product as List).map((v) {
            return ProductModel.fromJson(v);
          });
          return decondingData.toList();
        },
        urlString: uri.toString()
    );
    return result;
  }
}
