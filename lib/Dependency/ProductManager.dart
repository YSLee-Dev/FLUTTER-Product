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
  Future<List<ProductModel>> requestMainProduct(int page, int count) {
    // TODO: implement requestMainProduct
    throw UnimplementedError();
  }

}