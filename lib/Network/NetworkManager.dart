import 'dart:convert';
import 'package:flutter_product/Network/INetworkManager.dart';
import 'package:http/http.dart' as http;

import 'BaseModel.dart';

class NetworkManager implements INetworkManager {
  @override
  Future<T> requestData<T>({required T Function(Map<String, dynamic>) decoder, required String urlString, Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse(urlString);
    late http.Response response;

    if (body != null) { // post + body
      response = await http.post(
          uri,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body!
      );
    } else { // get
      response = await http.get(uri);
    }

    if (response.statusCode != 200) {
      throw Exception('Failed to load data: ${response.statusCode}');
    }

    final json = jsonDecode(response.body);
    return decoder(json);
  }
}