import 'package:flutter/foundation.dart';
import 'package:flutter_product/Component/Dependency/IProductManager.dart';
import 'package:flutter_product/Component/Dependency/ProductManager.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:flutter_product/Component/Network/INetworkManager.dart';

class DetailViewModel with ChangeNotifier  {
  final ProductModel sendedDetailInfo;

  DetailViewModel({required ProductModel model }) : sendedDetailInfo = model;
}