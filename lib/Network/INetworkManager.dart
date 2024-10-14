import 'BaseModel.dart';

abstract class INetworkManager {
  Future<T> requestData<T>(
      {required T Function(Map<String, dynamic>) decoder,
      required String urlString,
      Map<String, dynamic>? body});
}
