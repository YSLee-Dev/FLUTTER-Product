import 'package:dio/dio.dart';
import 'package:flutter_product/Component/Model/ProductModel.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'ProductNetworkService.g.dart';

@RestApi()
abstract class ProductNetworkService {
  factory ProductNetworkService(Dio dio) = _ProductNetworkService;

  @GET("/products")
  Future<ProductResponseModel> requestMainList(@Query("limit") String limit, @Query("skip") String page);

  @GET("/products/search")
  Future<ProductResponseModel> requestQuerySearch(@Query("q") String query, @Query("limit") String limit, @Query("skip") String page);
}