import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'MainDio.g.dart';

@Riverpod()
Dio mainDio(MainDioRef ref, String baseURL) {
  return Dio(BaseOptions(
    baseUrl: baseURL,
    connectTimeout: const Duration(milliseconds: 3000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ));
}